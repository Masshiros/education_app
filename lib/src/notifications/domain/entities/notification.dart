
import 'package:education_app/core/enums/notifications.enum.dart';
import 'package:equatable/equatable.dart';

class Notification extends Equatable {
  const Notification({
    required this.id,
    required this.title,
    required this.body,
    required this.category,
    required this.sentAt,
    this.seen = false,
  });

  Notification.empty()
      : id = '_empty.id',
        title = '_empty.title',
        body = '_empty.body',
        category = ENotification.NONE,
        seen = false,
        sentAt = DateTime.now();

  final String id;
  final String title;
  final String body;
  final ENotification category;
  final bool seen;
  final DateTime sentAt;

  @override
  List<Object?> get props => [id];
}
