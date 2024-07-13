import 'package:education_app/core/common/views/loading-view.dart';
import 'package:education_app/core/common/widgets/not-found-text.dart';
import 'package:education_app/core/extensions/context.extension.dart';
import 'package:education_app/core/services/dependencies-container.dart';
import 'package:education_app/core/utils/core-utils.dart';
import 'package:education_app/src/course/features/videos/presentation/cubit/video-cubit.dart';
import 'package:education_app/src/home/presentation/widgets/section-header.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomeVideos extends StatefulWidget {
  const HomeVideos({super.key});

  @override
  State<HomeVideos> createState() => _HomeVideosState();
}

class _HomeVideosState extends State<HomeVideos> {
  void getVideos() {
    context.read<VideoCubit>().getVideos(context.courseOfTheDay!.id);
  }

  @override
  void initState() {
    super.initState();
    getVideos();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VideoCubit, VideoState>(
      listener: (context, state) {
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
            'No videos found for ${context.courseOfTheDay!.title}',
          );
        } else if (state is VideosLoaded) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(
                title: '${context.courseOfTheDay!.title} Videos',
                seeAll: state.videos.length > 4,
                onSeeAll: () => context.push(
                  BlocProvider(
                    create: (_) => getIt<VideoCubit>(),
                    // child: CourseVideosView(),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              for (final video in state.videos.take(5)) const Placeholder(),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
