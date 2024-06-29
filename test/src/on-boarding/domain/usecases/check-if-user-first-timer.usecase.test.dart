import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/src/on-boarding/domain/usecases/cache-first-timer.usecase.dart';
import 'package:education_app/src/on-boarding/domain/usecases/check-if-user-first-timer.usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'on-boarding-repo.mock.dart';

void main() {
  late MockOnBoardingRepo repo;
  late CheckIfUserFirstTimerUseCase usecase;
  setUp(() {
    repo = MockOnBoardingRepo();
    usecase = CheckIfUserFirstTimerUseCase(repo);
  });
  test("should get a response from [OnBoardingRepo]", () async {
    when(() => repo.checkIfUserIsFirstTimer())
        .thenAnswer((_) async => const Right(true));
    final result = await usecase();
    expect(result, equals(const Right<dynamic, bool>(true)));
    verify(() => repo.checkIfUserIsFirstTimer()).called(1);
    verifyNoMoreInteractions(repo);
  });
}
