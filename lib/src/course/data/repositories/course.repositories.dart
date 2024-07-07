import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/data/datasources/course.data-source.dart';
import 'package:education_app/src/course/domain/entities/course.entities.dart';
import 'package:education_app/src/course/domain/repositories/course.repo.dart';

class CourseRepository implements ICourseRepository {
  const CourseRepository(this._dataSource);
  final CourseDataSource _dataSource;
  @override
  ResultFuture<void> addCourse(Course course) {
    // TODO: implement addCourse
    throw UnimplementedError();
  }

  @override
  ResultFuture<List<Course>> getCourses() {
    // TODO: implement getCourses
    throw UnimplementedError();
  }
}
