
import 'package:dartz/dartz.dart';
import 'package:education_app/src/course/features/resources/domain/entities/resource.entities.dart';
import 'package:education_app/src/course/features/resources/domain/usecases/add-resource.usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'resource.repo.mock.dart';

void main() {
  late MockResourceRepo repo;
  late AddResourceUseCase usecase;

  final tResource = Resource.empty();

  setUp(() {
    repo = MockResourceRepo();
    usecase = AddResourceUseCase(repo);
    registerFallbackValue(tResource);
  });

  test(
    'should call the [ResourceRepo.addResource]',
    () async {
      when(
        () => repo.addResource(
          any(),
        ),
      ).thenAnswer(
        (_) async => const Right(null),
      );

      final result = await usecase(tResource);
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(
        () => repo.addResource(
          any(),
        ),
      ).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
