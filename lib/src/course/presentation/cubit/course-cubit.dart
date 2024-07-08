import 'package:bloc/bloc.dart';
import 'package:education_app/src/course/domain/entities/course.entities.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'course-state.dart';

class CourseCubit extends Cubit<CourseState> {
  CourseCubit() : super(CourseInitial());
}
