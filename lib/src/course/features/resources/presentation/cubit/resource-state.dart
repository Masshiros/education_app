part of 'resource-cubit.dart';

abstract class ResourceState extends Equatable {
  const ResourceState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ResourceInitial extends ResourceState {
  const ResourceInitial();
}

class AddingResource extends ResourceState {
  const AddingResource();
}

class LoadingResources extends ResourceState {
  const LoadingResources();
}

class ResourceAdded extends ResourceState {
  const ResourceAdded();
}

class ResourcesLoaded extends ResourceState {
  const ResourcesLoaded(this.resources);

  final List<Resource> resources;

  @override
  List<Object> get props => [resources];
}

class ResourceError extends ResourceState {
  const ResourceError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
