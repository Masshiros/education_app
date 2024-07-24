import 'package:equatable/equatable.dart';

class Message extends Equatable {
  const Message({
    required this.id,
    required this.senderId,
    required this.message,
    required this.timestamp,
    required this.groupId,
  });

  Message.empty()
      : id = '',
        senderId = '',
        message = '',
        groupId = '',
        timestamp = DateTime.now();

  @override
  String toString() {
    return 'Message{id: $id, senderId: $senderId, message: $message, groupId: '
        '$groupId, timestamp: $timestamp}';
  }

  final String id;
  final String senderId;
  final String message;
  final String groupId;
  final DateTime timestamp;

  @override
  List<Object> get props => [id, groupId];
}
