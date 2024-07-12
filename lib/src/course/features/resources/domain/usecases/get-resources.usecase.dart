import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/resources/domain/entities/resource.entities.dart';
import 'package:education_app/src/course/features/resources/domain/repositories/resource.repositories.dart';

class GetResourcesUseCase extends UsecaseWithParams<List<Resource>, String> {
  const GetResourcesUseCase(this._repo);
  final IResourceRepository _repo;
  @override
  ResultFuture<List<Resource>> call(String params) async =>
      _repo.getResources(params);
}
