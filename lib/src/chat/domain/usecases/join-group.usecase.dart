import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/chat/domain/repositories/chat.repositories.dart';
import 'package:equatable/equatable.dart';

class JoinGroupUseCase extends UsecaseWithParams<void, JoinGroupParams> {
  const JoinGroupUseCase(this._repo);
  final IChatRepositories _repo;
  @override
  ResultFuture<void> call(JoinGroupParams params) async =>
      _repo.joinGroup(groupId: params.groupId, userId: params.userId);
}

class JoinGroupParams extends Equatable {
  const JoinGroupParams({required this.groupId, required this.userId});
  const JoinGroupParams.empty()
      : groupId = '',
        userId = '';
  final String groupId;
  final String userId;
  @override
  // TODO: implement props
  List<Object?> get props => [groupId, userId];
}
