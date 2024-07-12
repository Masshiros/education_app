import 'package:bloc/bloc.dart';
import 'package:education_app/src/course/features/videos/domain/entities/video.entities.dart';
import 'package:education_app/src/course/features/videos/domain/usecases/add-video.usecase.dart';
import 'package:education_app/src/course/features/videos/domain/usecases/get-videos.usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'video-state.dart';

class VideoCubit extends Cubit<VideoState> {
  VideoCubit(
      {required AddVideoUseCase addVideo, required GetVideosUseCase getVideos})
      : _addVideo = addVideo,
        _getVideos = getVideos,
        super(const VideoInitial());
  final AddVideoUseCase _addVideo;
  final GetVideosUseCase _getVideos;
  Future<void> addVideo(Video video) async {
    emit(const AddingVideo());
    final result = await _addVideo(video);
    result.fold((failure) => emit(VideoError(failure.errorMessage)),
        (_) => emit(const VideoAdded()));
  }

  Future<void> getVideos(String courseId) async {
    emit(const LoadingVideos());
    final result = await _getVideos(courseId);
    result.fold(
      (failure) => emit(VideoError(failure.errorMessage)),
      (videos) => emit(VideosLoaded(videos)),
    );
  }
}
