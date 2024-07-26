part of 'chat-cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {
  const ChatInitial();
}

class LoadingGroups extends ChatState {
  const LoadingGroups();
}

class LoadingMessages extends ChatState {
  const LoadingMessages();
}

class SendingMessage extends ChatState {
  const SendingMessage();
}

class JoiningGroup extends ChatState {
  const JoiningGroup();
}

class LeavingGroup extends ChatState {
  const LeavingGroup();
}

class GettingUser extends ChatState {
  const GettingUser();
}

class MessageSent extends ChatState {
  const MessageSent();
}

class GroupsLoaded extends ChatState {
  const GroupsLoaded(this.groups);

  final List<Group> groups;

  @override
  List<Object> get props => [groups];
}

class UserFound extends ChatState {
  const UserFound(this.user);

  final LocalUser user;

  @override
  List<Object> get props => [user];
}

class MessagesLoaded extends ChatState {
  const MessagesLoaded(this.messages);

  final List<Message> messages;

  @override
  List<Object> get props => [messages];
}

class LeftGroup extends ChatState {
  const LeftGroup();
}

class JoinedGroup extends ChatState {
  const JoinedGroup();
}

class ChatError extends ChatState {
  const ChatError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
