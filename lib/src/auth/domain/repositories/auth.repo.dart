import 'package:education_app/core/enums/update-user.enum.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/domain/entities/user.entities.dart';

abstract interface class IAuthRepository {
  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  });
  ResultFuture<void> signUp({
    required String email,
    required String fullName,
    required String password,
  });
  ResultFuture<void> forgotPassword(String email);
  ResultFuture<void> updateUser({
    required EUpdateUserAction action,
    required dynamic userData,
  });
}
