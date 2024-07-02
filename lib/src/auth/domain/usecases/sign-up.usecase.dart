import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/domain/repositories/auth.repo.dart';
import 'package:equatable/equatable.dart';

class SignUpUseCase extends UsecaseWithParams<void, SignUpParams> {
  const SignUpUseCase(this._repo);
  final IAuthRepository _repo;
  @override
  ResultFuture<void> call(params) => _repo.signUp(
      email: params.email,
      fullName: params.fullName,
      password: params.password);
}

class SignUpParams extends Equatable {
  const SignUpParams({
    required this.email,
    required this.password,
    required this.fullName,
  });

  const SignUpParams.empty()
      : email = '',
        password = '',
        fullName = '';

  final String email;
  final String password;
  final String fullName;

  @override
  List<String> get props => [email, password, fullName];
}
