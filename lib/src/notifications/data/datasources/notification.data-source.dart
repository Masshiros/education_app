import 'package:education_app/src/notifications/data/models/notification.models.dart';
import 'package:education_app/src/notifications/domain/entities/notification.dart';

abstract interface class NotificationDataSource {
  const NotificationDataSource();
  Future<void> clear(String notificationId);
  Future<void> clearAll();
  Future<void> markAsRead(String notificationId);
  Future<void> sendNotification(Notification notification);
  Stream<List<NotificationModel>> getNotifications();
}
