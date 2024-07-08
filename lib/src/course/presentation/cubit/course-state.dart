part of 'course-cubit.dart';

abstract class CourseState extends Equatable {
  const CourseState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CourseInitial extends CourseState {
  const CourseInitial();
}

class LoadingCourses extends CourseState {
  const LoadingCourses();
}

class AddingCourse extends CourseState {
  const AddingCourse();
}

class CourseAdded extends CourseState {
  const CourseAdded();
}

class CoursesLoaded extends CourseState {
  const CoursesLoaded(this.courses);
  final List<Course> courses;
  @override
  // TODO: implement props
  List<Object> get props => [courses];
}

class CourseError extends CourseState {
  const CourseError(this.message);
  final String message;
  @override
  // TODO: implement props
  List<Object> get props => [message];
}
