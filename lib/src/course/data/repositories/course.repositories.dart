import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/data/datasources/course.data-source.dart';
import 'package:education_app/src/course/domain/entities/course.entities.dart';
import 'package:education_app/src/course/domain/repositories/course.repo.dart';

class CourseRepository implements ICourseRepository {
  const CourseRepository(this._dataSource);
  final CourseDataSource _dataSource;
  @override
  ResultFuture<void> addCourse(Course course) async {
    try {
      await _dataSource.addCourse(course);
      return Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<Course>> getCourses() async {
    try {
      final result = await _dataSource.getCourses();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
