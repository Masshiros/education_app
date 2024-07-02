import 'package:education_app/core/enums/update-user.enum.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/data/datasources/auth.data-source.dart';
import 'package:education_app/src/auth/domain/entities/user.entities.dart';
import 'package:education_app/src/auth/domain/repositories/auth.repo.dart';

class AuthRepository implements IAuthRepository {
  const AuthRepository(this._dataSource);
  final AuthDataSource _dataSource;
  @override
  ResultFuture<void> forgotPassword(String email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  ResultFuture<LocalUser> signIn(
      {required String email, required String password}) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  ResultFuture<void> signUp(
      {required String email,
      required String fullName,
      required String password}) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  ResultFuture<void> updateUser(
      {required EUpdateUserAction action, required userData}) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
