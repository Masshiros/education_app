import 'package:dartz/dartz.dart';
import 'package:education_app/core/enums/update-user.enum.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/data/datasources/auth.data-source.dart';
import 'package:education_app/src/auth/domain/entities/user.entities.dart';
import 'package:education_app/src/auth/domain/repositories/auth.repo.dart';

class AuthRepository implements IAuthRepository {
  const AuthRepository(this._dataSource);
  final AuthDataSource _dataSource;
  @override
  ResultFuture<void> forgotPassword(String email) async {
    try {
      return Right(await _dataSource.forgotPassword(email));
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<LocalUser> signIn(
      {required String email, required String password}) async {
    try {
      return Right(await _dataSource.signIn(email: email, password: password));
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> signUp(
      {required String email,
      required String fullName,
      required String password}) async {
    try {
      return Right(await _dataSource.signUp(
          email: email, fullName: fullName, password: password));
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> updateUser(
      {required EUpdateUserAction action, required userData}) async {
    try {
      return Right(
          await _dataSource.updateUser(action: action, userData: userData));
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
