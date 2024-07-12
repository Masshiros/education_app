part of 'video-cubit.dart';

abstract class VideoState extends Equatable {
  const VideoState();
  @override
  List<Object> get props => [];
}

class VideoInitial extends VideoState {
  const VideoInitial();
}

class AddingVideo extends VideoState {
  const AddingVideo();
}

class LoadingVideos extends VideoState {
  const LoadingVideos();
}

class VideoAdded extends VideoState {
  const VideoAdded();
}

class VideosLoaded extends VideoState {
  const VideosLoaded(this.videos);

  final List<Video> videos;

  @override
  List<Object> get props => [videos];
}

class VideoError extends VideoState {
  const VideoError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
