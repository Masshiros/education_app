import 'package:dartz/dartz.dart';
import 'package:education_app/src/auth/domain/usecases/sign-up.usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth-repo.mock.dart';

void main() {
  late MockAuthRepo repo;
  late SignUpUseCase usecase;

  const tEmail = 'Test email';
  const tPassword = 'Test password';
  const tFullName = 'Test full name';

  setUp(() {
    repo = MockAuthRepo();
    usecase = SignUpUseCase(repo);
  });

  test(
    'should call the [AuthRepo]',
    () async {
      when(
        () => repo.signUp(
          email: any(named: 'email'),
          fullName: any(named: 'fullName'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => const Right(null),
      );

      final result = await usecase(
        const SignUpParams(
          email: tEmail,
          password: tPassword,
          fullName: tFullName,
        ),
      );

      expect(result, const Right<dynamic, void>(null));

      verify(
        () => repo.signUp(
          email: tEmail,
          password: tPassword,
          fullName: tFullName,
        ),
      ).called(1);

      verifyNoMoreInteractions(repo);
    },
  );
}
