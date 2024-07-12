import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/resources/domain/entities/resource.entities.dart';
import 'package:education_app/src/course/features/resources/domain/repositories/resource.repositories.dart';

class AddResourceUseCase extends UsecaseWithParams<void, Resource> {
  const AddResourceUseCase(this._repo);
  final IResourceRepository _repo;

  @override
  ResultFuture<void> call(Resource params) async => _repo.addResource(params);
}
