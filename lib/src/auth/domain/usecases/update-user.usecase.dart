import 'package:education_app/core/enums/update-user.enum.dart';
import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/domain/repositories/auth.repo.dart';
import 'package:equatable/equatable.dart';

class UpdateUserUseCase extends UsecaseWithParams<void, UpdateUserParams> {
  const UpdateUserUseCase(this._repo);

  final IAuthRepository _repo;

  @override
  ResultFuture<void> call(UpdateUserParams params) => _repo.updateUser(
        action: params.action,
        userData: params.userData,
      );
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams({required this.action, required this.userData});

  const UpdateUserParams.empty()
      : this(
          action: EUpdateUserAction.displayName,
          userData: '',
        );

  final EUpdateUserAction action;
  final dynamic userData;

  @override
  List<dynamic> get props => [action, userData];
}
