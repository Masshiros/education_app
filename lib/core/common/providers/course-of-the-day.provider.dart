import 'package:education_app/src/course/domain/entities/course.entities.dart';
import 'package:flutter/material.dart';

class CourseOfTheDayNotifier extends ChangeNotifier {
  Course? _courseOfTheDay;
  Course? get courseOfTheday => _courseOfTheDay;
  void setCourseOfTheDay(Course course) {
    _courseOfTheDay ??= course;
  }
}
