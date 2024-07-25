import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/chat/domain/entities/message.entities.dart';
import 'package:education_app/src/chat/domain/repositories/chat.repositories.dart';

class GetMessagesUseCase
    extends StreamUsecaseWithParams<List<Message>, String> {
  const GetMessagesUseCase(this._repo);
  final IChatRepositories _repo;

  @override
  ResultStream<List<Message>> call(String params) => _repo.getMessages(params);
}
