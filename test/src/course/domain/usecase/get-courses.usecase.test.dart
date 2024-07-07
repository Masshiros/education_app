import 'package:dartz/dartz.dart';
import 'package:education_app/src/course/domain/entities/course.entities.dart';
import 'package:education_app/src/course/domain/repositories/course.repo.dart';
import 'package:education_app/src/course/domain/usecases/get-courses.usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'course-repo.mock.dart';

void main() {
  late ICourseRepository repo;
  late GetCoursesUseCase useCase;
  setUp(() {
    repo = MockCourseRepo();
    useCase = GetCoursesUseCase(repo);
  });

  test('should get courses from the repo', () async {
    // arrange
    when(() => repo.getCourses()).thenAnswer((_) async => const Right([]));
    // act
    final result = await useCase();
    // assert
    expect(result, const Right<dynamic, List<Course>>([]));
    verify(() => repo.getCourses()).called(1);
    verifyNoMoreInteractions(repo);
  });
}
