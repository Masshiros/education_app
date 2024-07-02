
import 'package:dartz/dartz.dart';
import 'package:education_app/src/auth/domain/usecases/forgot-password.usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth-repo.mock.dart';

void main() {
  late MockAuthRepo repo;
  late ForgotPasswordUseCase usecase;

  setUp(() {
    repo = MockAuthRepo();
    usecase = ForgotPasswordUseCase(repo);
  });

  test(
    'should call the [AuthRepo.forgotPassword]',
    () async {
      when(() => repo.forgotPassword(any())).thenAnswer(
        (_) async => const Right(null),
      );

      final result = await usecase('email');

      expect(result, equals(const Right<dynamic, void>(null)));

      verify(() => repo.forgotPassword('email')).called(1);

      verifyNoMoreInteractions(repo);
    },
  );
}
