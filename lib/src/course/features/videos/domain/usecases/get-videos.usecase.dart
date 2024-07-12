import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/videos/domain/entities/video.entities.dart';
import 'package:education_app/src/course/features/videos/domain/repositories/video.repositories.dart';

class GetVideosUseCase extends UsecaseWithParams<List<Video>, String> {
  const GetVideosUseCase(this._repo);
  final IVideoRepository _repo;
  @override
  ResultFuture<List<Video>> call(String params) => _repo.getVideos(params);
}
