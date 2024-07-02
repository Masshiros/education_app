
import 'package:dartz/dartz.dart';
import 'package:education_app/core/enums/update-user.enum.dart';
import 'package:education_app/src/auth/domain/usecases/update-user.usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth-repo.mock.dart';

void main() {
  late MockAuthRepo repo;
  late UpdateUserUseCase usecase;

  setUp(() {
    repo = MockAuthRepo();
    usecase = UpdateUserUseCase(repo);
    registerFallbackValue(EUpdateUserAction.email);
  });

  test(
    'should call the [AuthRepo]',
    () async {
      when(
        () => repo.updateUser(
          action: any(named: 'action'),
          userData: any<dynamic>(named: 'userData'),
        ),
      ).thenAnswer((_) async => const Right(null));

      final result = await usecase(
        const UpdateUserParams(
          action: EUpdateUserAction.email,
          userData: 'Test email',
        ),
      );

      expect(result, const Right<dynamic, void>(null));

      verify(
        () => repo.updateUser(
          action: EUpdateUserAction.email,
          userData: 'Test email',
        ),
      ).called(1);

      verifyNoMoreInteractions(repo);
    },
  );
}
