import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/videos/domain/entities/video.entities.dart';
import 'package:education_app/src/course/features/videos/domain/repositories/video.repositories.dart';

class AddVideoUseCase extends UsecaseWithParams<void, Video> {
  const AddVideoUseCase(this._repo);
  final IVideoRepository _repo;
  @override
  ResultFuture<void> call(Video params) => _repo.addVideo(params);
}
