import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/auth/domain/entities/user.entities.dart';
import 'package:education_app/src/chat/domain/repositories/chat.repositories.dart';

class GetUserByIdUseCase extends UsecaseWithParams<LocalUser, String> {
  const GetUserByIdUseCase(this._repo);
  final IChatRepositories _repo;
  @override
  ResultFuture<LocalUser> call(String params) async =>
      _repo.getUserById(params);
}
