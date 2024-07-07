import 'package:education_app/src/course/domain/entities/course.entities.dart';

abstract interface class CourseDataSource {
  Future<void> addCourse(Course course);

  Future<List<Course>> getCourses();
}
