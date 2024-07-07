import 'package:dartz/dartz.dart';
import 'package:education_app/src/course/domain/entities/course.entities.dart';
import 'package:education_app/src/course/domain/repositories/course.repo.dart';
import 'package:education_app/src/course/domain/usecases/add-course.usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'course-repo.mock.dart';

void main() {
  late ICourseRepository repo;
  late AddCourseUseCase usecase;
  final tCourse = Course.empty();
  setUp(() {
    repo = MockCourseRepo();
    usecase = AddCourseUseCase(repo);
    registerFallbackValue(tCourse);
  });
  test('should call [CourseRepo.addCourse]', () async {
    when(() => repo.addCourse(any()))
        .thenAnswer((_) async => const Right(null));
    await usecase.call(tCourse);
    verify(() => repo.addCourse(tCourse)).called(1);
    verifyNoMoreInteractions(repo);
  });
}
