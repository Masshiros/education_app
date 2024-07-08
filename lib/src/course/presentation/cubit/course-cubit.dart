import 'package:bloc/bloc.dart';
import 'package:education_app/src/course/domain/entities/course.entities.dart';
import 'package:education_app/src/course/domain/usecases/add-course.usecase.dart';
import 'package:education_app/src/course/domain/usecases/get-courses.usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'course-state.dart';

class CourseCubit extends Cubit<CourseState> {
  CourseCubit({
    required AddCourseUseCase addCourse,
    required GetCoursesUseCase getCourses,
  })  : _addCourse = addCourse,
        _getCourses = getCourses,
        super(const CourseInitial());

  final AddCourseUseCase _addCourse;
  final GetCoursesUseCase _getCourses;
  Future<void> addCourse(Course course) async {
    emit(const AddingCourse());
    final result = await _addCourse(course);
    result.fold(
      (failure) => emit(CourseError(failure.errorMessage)),
      (_) => emit(const CourseAdded()),
    );
  }

  Future<void> getCourses() async {
    emit(const LoadingCourses());
    final result = await _getCourses();
    result.fold(
      (failure) => emit(CourseError(failure.errorMessage)),
      (courses) => emit(CoursesLoaded(courses)),
    );
  }
}
