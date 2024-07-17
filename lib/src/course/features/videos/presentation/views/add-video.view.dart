import 'package:education_app/core/common/widgets/course-picker.dart';
import 'package:education_app/core/common/widgets/info-field.dart';
import 'package:education_app/core/common/widgets/reactive-button.dart';
import 'package:education_app/core/common/widgets/video-tile.dart';
import 'package:education_app/core/enums/notifications.enum.dart';
import 'package:education_app/core/extensions/string.extension.dart';
import 'package:education_app/core/utils/core-utils.dart';
import 'package:education_app/src/course/domain/entities/course.entities.dart';
import 'package:education_app/src/course/features/videos/data/models/video.models.dart';
import 'package:education_app/src/course/features/videos/presentation/cubit/video-cubit.dart';
import 'package:education_app/src/course/features/videos/presentation/utils/video-utils.dart';
import 'package:education_app/src/notifications/presentation/widgets/notification-wrapper.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;
import 'package:flutter_link_previewer/flutter_link_previewer.dart';

class AddVideoView extends StatefulWidget {
  const AddVideoView({super.key});
  static const routeName = '/add-video';

  @override
  State<AddVideoView> createState() => _AddVideoViewState();
}

class _AddVideoViewState extends State<AddVideoView> {
  final urlController = TextEditingController();
  final authorController = TextEditingController(text: 'mashiro');
  final titleController = TextEditingController();
  final courseController = TextEditingController();
  final courseNotifier = ValueNotifier<Course?>(null);
  final formKey = GlobalKey<FormState>();
  VideoModel? video;
  PreviewData? previewData;
  final authorFocusNode = FocusNode();
  final titleFocusNode = FocusNode();
  final urlFocusNode = FocusNode();
  bool getMoreDetails = false;
  bool get isYoutube => urlController.text.trim().isYoutubeVideo;

  bool thumbNailIsFile = false;
  bool loading = false;
  bool showingDialog = false;
  void reset() {
    setState(() {
      urlController.clear();
      authorController.text = 'mashiro';
      titleController.clear();
      getMoreDetails = false;
      loading = false;
      video = null;
      previewData = null;
    });
  }

  @override
  void initState() {
    super.initState();
    urlController.addListener(() {
      if (urlController.text.trim().isEmpty) reset();
    });
    authorController.addListener(() {
      video = video?.copyWith(tutor: authorController.text.trim());
    });
    titleController.addListener(() {
      video = video?.copyWith(title: titleController.text.trim());
    });
  }

  Future<void> fetchVideo() async {
    if (urlController.text.trim().isEmpty) return;

    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      getMoreDetails = false;
      loading = false;
      thumbNailIsFile = false;
      video = null;
      previewData = null;
    });
    setState(() {
      loading = true;
    });
    if (isYoutube) {
      video = await VideoUtils.getVideoFromYT(
        context,
        url: urlController.text.trim(),
      ) as VideoModel?;
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void dispose() {
    urlController.dispose();
    authorController.dispose();
    titleController.dispose();
    courseController.dispose();
    courseNotifier.dispose();
    urlFocusNode.dispose();
    titleFocusNode.dispose();
    authorFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationWrapper(
      onNotificationSent: () {
        Navigator.of(context).pop();
      },
      child: BlocListener<VideoCubit, VideoState>(
        listener: (context, state) {
          if (showingDialog == true) {
            Navigator.pop(context);
            showingDialog = false;
          }
          if (state is AddingVideo) {
            CoreUtils.showLoadingDialog(context);
            showingDialog = true;
          } else if (state is VideoError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is VideoAdded) {
            CoreUtils.showSnackBar(context, 'Video added successfully');
            CoreUtils.sendNotification(
              context,
              title: 'New ${courseNotifier.value!.title} video',
              body: 'A new video has been added for '
                  '${courseNotifier.value!.title}',
              category: ENotification.VIDEO,
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Add Video'),
          ),
          body: ListView(
            children: [
              Form(
                key: formKey,
                child: CoursePicker(
                  controller: courseController,
                  notifier: courseNotifier,
                ),
              ),
              const SizedBox(height: 20),
              InfoField(
                controller: urlController,
                hintText: 'Enter video URL',
                onEditingComplete: fetchVideo,
                focusNode: urlFocusNode,
                onTapOutside: (_) => urlFocusNode.unfocus(),
                autoFocus: true,
                keyboardType: TextInputType.url,
              ),
              ListenableBuilder(
                listenable: urlController,
                builder: (_, __) {
                  return Column(
                    children: [
                      if (urlController.text.trim().isNotEmpty) ...[
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: fetchVideo,
                          child: const Text('Fetch Video'),
                        )
                      ]
                    ],
                  );
                },
              ),
              if (loading && !isYoutube)
                LinkPreview(
                  onPreviewDataFetched: (data) async {
                    setState(() {
                      thumbNailIsFile = false;
                      video = VideoModel.empty().copyWith(
                        thumbnail: data.image?.url,
                        videoURL: urlController.text.trim(),
                        title: data.title ?? 'No title',
                      );
                      if (data.image?.url != null) loading = false;
                      getMoreDetails = true;
                      titleController.text = data.title ?? '';
                      loading = false;
                    });
                  },
                  previewData: previewData,
                  text: '',
                  width: 0,
                ),
              if (video != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: VideoTile(
                    video!,
                    isFile: thumbNailIsFile,
                    uploadTimePrefix: '~',
                  ),
                ),
              if (getMoreDetails) ...[
                InfoField(
                  controller: authorController,
                  keyboardType: TextInputType.name,
                  autoFocus: true,
                  focusNode: authorFocusNode,
                  labelText: 'Tutor Name',
                  onEditingComplete: () {
                    setState(() {});
                    titleFocusNode.requestFocus();
                  },
                ),
                InfoField(
                  controller: titleController,
                  labelText: 'Video Title',
                  focusNode: titleFocusNode,
                  onEditingComplete: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    setState(() {});
                  },
                ),
              ],
              const SizedBox(height: 20),
              Center(
                child: ReactiveButton(
                  disabled: video == null,
                  loading: loading,
                  text: 'Submit',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (courseNotifier.value == null) {
                        CoreUtils.showSnackBar(context, 'Please Pick a course');
                        return;
                      }
                      if (courseNotifier.value != null &&
                          video != null &&
                          video!.tutor == null &&
                          authorController.text.trim().isNotEmpty) {
                        video = video!.copyWith(
                          tutor: authorController.text.trim(),
                        );
                      }
                      if (video != null &&
                          video!.tutor != null &&
                          video!.title != null &&
                          video!.title!.isNotEmpty) {
                        video = video?.copyWith(
                          thumbnailIsFile: thumbNailIsFile,
                          courseId: courseNotifier.value!.id,
                          uploadDate: DateTime.now(),
                        );
                        context.read<VideoCubit>().addVideo(video!);
                      } else {
                        CoreUtils.showSnackBar(
                          context,
                          'Please Fill all fields',
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
