import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/chat/domain/repositories/chat.repositories.dart';
import 'package:equatable/equatable.dart';

class LeaveGroupUseCase extends UsecaseWithParams<void, LeaveGroupParams> {
  const LeaveGroupUseCase(this._repo);
  final IChatRepositories _repo;

  @override
  ResultFuture<void> call(LeaveGroupParams params) async =>
      _repo.leaveGroup(groupId: params.groupId, userId: params.userId);
}

class LeaveGroupParams extends Equatable {
  const LeaveGroupParams({required this.groupId, required this.userId});
  const LeaveGroupParams.empty()
      : this.groupId = '',
        this.userId = '';
  final String groupId;
  final String userId;

  @override
  // TODO: implement props
  List<Object?> get props => [userId, groupId];
}
