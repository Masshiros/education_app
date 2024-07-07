import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/domain/entities/course.entities.dart';

abstract interface class ICourseRepository {
  const ICourseRepository();
  ResultFuture<void> addCourse(Course course);
  ResultFuture<List<Course>> getCourses();
}
