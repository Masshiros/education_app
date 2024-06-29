import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/src/on-boarding/domain/usecases/cache-first-timer.usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'on-boarding-repo.mock.dart';

void main() {
  late MockOnBoardingRepo repo;
  late CacheFirstTimerUseCase usecase;
  setUp(() {
    repo = MockOnBoardingRepo();
    usecase = CacheFirstTimerUseCase(repo);
  });
  test("should get a response from [OnBoardingRepo]", () async {
    when(() => repo.cacheFirstTimer()).thenAnswer((_) async => Left(
          ServerFailure(
            message: 'Unknown Error Occurred',
            statusCode: 500,
          ),
        ));
    final result = await usecase();
    expect(
        result,
        equals(Left<Failure, dynamic>(
          ServerFailure(
            message: 'Unknown Error Occurred',
            statusCode: 500,
          ),
        )));
    verify(() => repo.cacheFirstTimer()).called(1);
    verifyNoMoreInteractions(repo);
  });
}
