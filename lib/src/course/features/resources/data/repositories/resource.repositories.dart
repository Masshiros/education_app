import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/resources/data/datasources/resource.data-source.dart';
import 'package:education_app/src/course/features/resources/domain/entities/resource.entities.dart';
import 'package:education_app/src/course/features/resources/domain/repositories/resource.repositories.dart';

class ResourceRepository implements IResourceRepository {
  const ResourceRepository(this._dataSource);
  final ResourceDataSource _dataSource;

  @override
  ResultFuture<void> addResource(Resource resource) async {
    try {
      await _dataSource.addResource(resource);
      return Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<Resource>> getResources(String courseId) async {
    try {
      return Right(await _dataSource.getResources(courseId));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
