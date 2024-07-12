import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/resources/domain/entities/resource.entities.dart';

abstract interface class IResourceRepository {
  const IResourceRepository();
  ResultFuture<List<Resource>> getResources(String courseId);
  ResultFuture<void> addResource(Resource resource);
}
