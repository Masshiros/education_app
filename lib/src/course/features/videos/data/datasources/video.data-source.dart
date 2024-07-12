import 'package:education_app/src/course/features/videos/data/models/video.models.dart';
import 'package:education_app/src/course/features/videos/domain/entities/video.entities.dart';

abstract class VideoDataSource{
  Future<List<VideoModel>> getVideos(String courseId);

  Future<void> addVideo(Video video);
}