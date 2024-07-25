import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/chat/domain/entities/group.entities.dart';
import 'package:education_app/src/chat/domain/repositories/chat.repositories.dart';

class GetGroupsUseCase extends StreamUsecaseWithoutParams<List<Group>> {
  const GetGroupsUseCase(this._repo);
  final IChatRepositories _repo;

  @override
  ResultStream<List<Group>> call() async* {
    _repo.getGroups();
  }
}
