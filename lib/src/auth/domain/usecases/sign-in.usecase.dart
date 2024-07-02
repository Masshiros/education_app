import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/domain/entities/user.entities.dart';
import 'package:education_app/src/auth/domain/repositories/auth.repo.dart';
import 'package:equatable/equatable.dart';

class SignInUseCase extends UsecaseWithParams<LocalUser, SignInParams> {
  const SignInUseCase(this._repo);
  final IAuthRepository _repo;
  @override
  ResultFuture<LocalUser> call(SignInParams params) {
    return _repo.signIn(email: params.email, password: params.password);
  }
}

class SignInParams extends Equatable {
  const SignInParams({
    required this.email,
    required this.password,
  });

  const SignInParams.empty()
      : email = '',
        password = '';

  final String email;
  final String password;

  @override
  List<String> get props => [email, password];
}
