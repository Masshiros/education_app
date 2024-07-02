
import 'package:dartz/dartz.dart';
import 'package:education_app/core/enums/update-user.enum.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/src/auth/data/datasources/auth.data-source.dart';
import 'package:education_app/src/auth/data/models/user.model.dart';
import 'package:education_app/src/auth/data/repositories/auth.repo.dart';
import 'package:education_app/src/auth/domain/entities/user.entities.dart';
import 'package:education_app/src/auth/domain/repositories/auth.repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock implements AuthDataSource {}

void main() {
  late MockAuthRemoteDataSource remoteDataSource;
  late IAuthRepository repoImpl;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();
    repoImpl = AuthRepository(remoteDataSource);
    registerFallbackValue(EUpdateUserAction.password);
  });

  const tPassword = 'Test password';
  const tFullName = 'Test full name';
  const tEmail = 'Test email';
  const tUpdateAction = EUpdateUserAction.password;
  const tUserData = 'New password';

  const tUser = LocalUserModel.empty();

  group('forgotPassword', () {
    test(
      'should return [void] when call to remote source is successful',
      () async {
        when(() => remoteDataSource.forgotPassword(any())).thenAnswer(
          (_) async => Future.value(),
        );

        final result = await repoImpl.forgotPassword(tEmail);

        expect(result, equals(const Right<dynamic, void>(null)));

        verify(() => remoteDataSource.forgotPassword(tEmail)).called(1);

        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return [ServerFailure] when call to remote source is '
      'unsuccessful',
      () async {
        when(() => remoteDataSource.forgotPassword(any())).thenThrow(
          const ServerException(
            message: 'User does not exist',
            statusCode: '404',
          ),
        );

        final result = await repoImpl.forgotPassword(tEmail);

        expect(
          result,
          equals(
            Left<dynamic, void>(
              ServerFailure(
                message: 'User does not exist',
                statusCode: '404',
              ),
            ),
          ),
        );

        verify(() => remoteDataSource.forgotPassword(tEmail)).called(1);

        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('signIn', () {
    test(
      'should return [LocalUser] when call to remote source is successful',
      () async {
        when(
          () => remoteDataSource.signIn(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer(
          (_) async => tUser,
        );

        final result = await repoImpl.signIn(
          email: tEmail,
          password: tPassword,
        );

        expect(result, equals(const Right<dynamic, LocalUser>(tUser)));

        verify(
          () => remoteDataSource.signIn(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);

        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return [ServerFailure] when call to remote source is '
      'unsuccessful',
      () async {
        when(
          () => remoteDataSource.signIn(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(
          const ServerException(
            message: 'User does not exist',
            statusCode: '404',
          ),
        );

        final result = await repoImpl.signIn(
          email: tEmail,
          password: tPassword,
        );

        expect(
          result,
          equals(
            Left<dynamic, void>(
              ServerFailure(
                message: 'User does not exist',
                statusCode: '404',
              ),
            ),
          ),
        );

        verify(
          () => remoteDataSource.signIn(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);

        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('signUp', () {
    test(
      'should return [void] when call to remote source is successful',
      () async {
        when(
          () => remoteDataSource.signUp(
            email: any(named: 'email'),
            fullName: any(named: 'fullName'),
            password: any(named: 'password'),
          ),
        ).thenAnswer(
          (_) async => Future.value(),
        );

        final result = await repoImpl.signUp(
          email: tEmail,
          fullName: tFullName,
          password: tPassword,
        );

        expect(result, equals(const Right<dynamic, void>(null)));

        verify(
          () => remoteDataSource.signUp(
            email: tEmail,
            fullName: tFullName,
            password: tPassword,
          ),
        ).called(1);

        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return [ServerFailure] when call to remote source is '
      'unsuccessful',
      () async {
        when(
          () => remoteDataSource.signUp(
            email: any(named: 'email'),
            fullName: any(named: 'fullName'),
            password: any(named: 'password'),
          ),
        ).thenThrow(
          const ServerException(
            message: 'User already exists',
            statusCode: '400',
          ),
        );

        final result = await repoImpl.signUp(
          email: tEmail,
          fullName: tFullName,
          password: tPassword,
        );

        expect(
          result,
          equals(
            Left<dynamic, void>(
              ServerFailure(
                message: 'User already exists',
                statusCode: '400',
              ),
            ),
          ),
        );

        verify(
          () => remoteDataSource.signUp(
            email: tEmail,
            fullName: tFullName,
            password: tPassword,
          ),
        ).called(1);

        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('updateUser', () {
    test(
      'should return [void] when call to remote source is successful',
      () async {
        when(
          () => remoteDataSource.updateUser(
            action: any(named: 'action'),
            userData: any<dynamic>(named: 'userData'),
          ),
        ).thenAnswer(
          (_) async => Future.value(),
        );

        final result = await repoImpl.updateUser(
          action: tUpdateAction,
          userData: tUserData,
        );

        expect(result, equals(const Right<dynamic, void>(null)));

        verify(
          () => remoteDataSource.updateUser(
            action: tUpdateAction,
            userData: tUserData,
          ),
        ).called(1);

        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return [ServerFailure] when call to remote source is '
      'unsuccessful',
      () async {
        when(
          () => remoteDataSource.updateUser(
            action: any(named: 'action'),
            userData: any<dynamic>(named: 'userData'),
          ),
        ).thenThrow(
          const ServerException(
            message: 'User does not exist',
            statusCode: '404',
          ),
        );

        final result = await repoImpl.updateUser(
          action: tUpdateAction,
          userData: tUserData,
        );

        expect(
          result,
          equals(
            Left<dynamic, void>(
              ServerFailure(
                message: 'User does not exist',
                statusCode: '404',
              ),
            ),
          ),
        );

        verify(
          () => remoteDataSource.updateUser(
            action: tUpdateAction,
            userData: tUserData,
          ),
        ).called(1);

        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}
