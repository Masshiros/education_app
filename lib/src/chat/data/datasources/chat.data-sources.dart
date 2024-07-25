
import 'package:education_app/src/auth/data/models/user.model.dart';
import 'package:education_app/src/chat/data/models/group.models.dart';
import 'package:education_app/src/chat/data/models/message.models.dart';
import 'package:education_app/src/chat/domain/entities/message.entities.dart';

abstract class ChatDataSource {
  const ChatDataSource();

  Future<void> sendMessage(Message message);

  // Should go to 'groups >> groupDoc >> messages >> orderBy('timestamp')
  Stream<List<MessageModel>> getMessages(String groupId);

  // Should go to 'groups'
  Stream<List<GroupModel>> getGroups();

  Future<void> joinGroup({required String groupId, required String userId});

  Future<void> leaveGroup({required String groupId, required String userId});

  Future<LocalUserModel> getUserById(String userId);
}
