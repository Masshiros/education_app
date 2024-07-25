import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/chat/domain/entities/message.entities.dart';
import 'package:education_app/src/chat/domain/repositories/chat.repositories.dart';

class SendMessageUseCase extends UsecaseWithParams<void, Message> {
  const SendMessageUseCase(this._repo);
  final IChatRepositories _repo;
  @override
  ResultFuture<void> call(Message params) async => _repo.sendMessage(params);
}
