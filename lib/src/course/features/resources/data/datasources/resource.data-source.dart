import 'package:education_app/src/course/features/resources/data/models/resource.models.dart';
import 'package:education_app/src/course/features/resources/domain/entities/resource.entities.dart';

abstract class ResourceDataSource{
  Future<List<ResourceModel>> getResources(String courseId);

  Future<void> addResource(Resource resource);
}