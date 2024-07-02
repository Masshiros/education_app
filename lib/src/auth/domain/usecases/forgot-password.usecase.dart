import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/domain/repositories/auth.repo.dart';

class ForgotPasswordUseCase extends UsecaseWithParams<void, String> {
  const ForgotPasswordUseCase(this._repo);

  final IAuthRepository _repo;

  @override
  ResultFuture<void> call(String params) => _repo.forgotPassword(params);
}
