import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/videos/data/datasources/video.data-source.dart';
import 'package:education_app/src/course/features/videos/domain/entities/video.entities.dart';
import 'package:education_app/src/course/features/videos/domain/repositories/video.repositories.dart';

class VideoRepository implements IVideoRepository {
  const VideoRepository(this._dataSource);
  final VideoDataSource _dataSource;
  @override
  ResultFuture<void> addVideo(Video video) async {
    try {
      await _dataSource.addVideo(video);
      return Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<Video>> getVideos(String courseId) async {
    try {
      return Right(await _dataSource.getVideos(courseId));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
