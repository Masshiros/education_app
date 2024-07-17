import 'package:education_app/core/common/views/loading-view.dart';
import 'package:education_app/core/common/widgets/gradient-background.dart';
import 'package:education_app/core/common/widgets/nested-back-button.dart';
import 'package:education_app/core/common/widgets/not-found-text.dart';
import 'package:education_app/core/common/widgets/video-tile.dart';
import 'package:education_app/core/global/colours.dart';
import 'package:education_app/core/global/media.dart';
import 'package:education_app/core/utils/core-utils.dart';
import 'package:education_app/src/course/domain/entities/course.entities.dart';
import 'package:education_app/src/course/features/videos/presentation/cubit/video-cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseVideosView extends StatefulWidget {
  const CourseVideosView(this.course, {super.key});
  static const routeName = '/course-videos';
  final Course course;
  @override
  State<CourseVideosView> createState() => _CourseVideosViewState();
}

class _CourseVideosViewState extends State<CourseVideosView> {
  void getVideos() {
    context.read<VideoCubit>().getVideos(widget.course.id);
  }

  @override
  void initState() {
    super.initState();
    getVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: const NestedBackButton(),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          ],
        ),
        body: GradientBackground(
          image: MediaRes.homeGradientBackground,
          child: BlocConsumer<VideoCubit, VideoState>(
            listener: (_, state) {
              if (state is VideoError) {
                CoreUtils.showSnackBar(context, state.message);
              }
            },
            builder: (context, state) {
              if (state is LoadingVideos) {
                return const LoadingView();
              } else if ((state is VideosLoaded && state.videos.isEmpty) ||
                  state is VideoError) {
                return NotFoundText(
                  'No videos found for ${widget.course.title}',
                );
              } else if (state is VideosLoaded) {
                final videos = state.videos
                  ..sort((a, b) => b.uploadDate.compareTo(a.uploadDate));
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.course.title} Videos',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${state.videos.length} video(s) found',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colours.neutralTextColour,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: state.videos.length,
                              itemBuilder: (_, index) {
                                return VideoTile(
                                  videos[index],
                                  tappable: true,
                                );
                              }))
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ));
  }
}
