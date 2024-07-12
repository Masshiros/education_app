import 'package:bloc/bloc.dart';
import 'package:education_app/src/course/features/resources/domain/entities/resource.entities.dart';
import 'package:education_app/src/course/features/resources/domain/usecases/add-resource.usecase.dart';
import 'package:education_app/src/course/features/resources/domain/usecases/get-resources.usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'resource-state.dart';

class ResourceCubit extends Cubit<ResourceState> {
  ResourceCubit({
    required AddResourceUseCase addResource,
    required GetResourcesUseCase getResources,
  })  : _addResource = addResource,
        _getResources = getResources,
        super(const ResourceInitial());

  final AddResourceUseCase _addResource;
  final GetResourcesUseCase _getResources;
  Future<void> addResources(List<Resource> resources) async {
    emit(const AddingResource());
    for (final resource in resources) {
      final result = await _addResource(resource);
      result.fold(
          (failure) => emit(ResourceError(failure.errorMessage)), (_) => null);
    }
    if (state is! ResourceError) emit(const ResourceAdded());
  }

  Future<void> getResources(String courseId) async {
    emit(const LoadingResources());
    final result = await _getResources(courseId);
    result.fold(
      (failure) => emit(ResourceError(failure.errorMessage)),
      (resources) => emit(ResourcesLoaded(resources)),
    );
  }
}
