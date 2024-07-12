import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/videos/data/datasources/video.data-source.dart';
import 'package:education_app/src/course/features/videos/domain/entities/video.entities.dart';
import 'package:education_app/src/course/features/videos/domain/repositories/video.repositories.dart';

class VideoRepository implements IVideoRepository {
  const VideoRepository(this._dataSource);
  final VideoDataSource _dataSource;
  @override
  ResultFuture<void> addVideo(Video video) {
    // TODO: implement addVideo
    throw UnimplementedError();
  }

  @override
  ResultFuture<List<Video>> getVideos(String courseId) {
    // TODO: implement getVideos
    throw UnimplementedError();
  }
}
