
import 'package:education_app/core/enums/update-user.enum.dart';
import 'package:education_app/src/auth/data/models/user.model.dart';

abstract class AuthDataSource {
  const AuthDataSource();

  Future<void> forgotPassword(String email);

  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String email,
    required String fullName,
    required String password,
  });

  Future<void> updateUser({
    required EUpdateUserAction action,
    required dynamic userData,
  });
}
