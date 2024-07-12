
import 'package:dartz/dartz.dart';
import 'package:education_app/src/course/features/resources/domain/entities/resource.entities.dart';
import 'package:education_app/src/course/features/resources/domain/usecases/get-resources.usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'resource.repo.mock.dart';

void main() {
  late MockResourceRepo repo;
  late GetResourcesUseCase usecase;

  const tCourseId = 'Test String';

  setUp(() {
    repo = MockResourceRepo();
    usecase = GetResourcesUseCase(repo);
    registerFallbackValue(tCourseId);
  });

  test(
    'should return [List<Resource>] from the repo',
    () async {
      when(
        () => repo.getResources(
          any(),
        ),
      ).thenAnswer(
        (_) async => const Right([]),
      );

      final result = await usecase(tCourseId);
      expect(result, equals(const Right<dynamic, List<Resource>>([])));
      verify(
        () => repo.getResources(
          any(),
        ),
      ).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
