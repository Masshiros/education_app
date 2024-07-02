import 'package:dartz/dartz.dart';
import 'package:education_app/src/auth/domain/entities/user.entities.dart';
import 'package:education_app/src/auth/domain/usecases/sign-in.usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth-repo.mock.dart';

void main() {
  late MockAuthRepo repo;
  late SignInUseCase usecase;

  const tEmail = 'Test email';
  const tPassword = 'Test password';

  setUp(() {
    repo = MockAuthRepo();
    usecase = SignInUseCase(repo);
  });

  const tUser = LocalUser.empty();

  test(
    'should return [LocalUser] from the [AuthRepo]',
    () async {
      when(
        () => repo.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => const Right(tUser));

      final result = await usecase(
        const SignInParams(
          email: tEmail,
          password: tPassword,
        ),
      );

      expect(result, const Right<dynamic, LocalUser>(tUser));

      verify(
        () => repo.signIn(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);

      verifyNoMoreInteractions(repo);
    },
  );
}