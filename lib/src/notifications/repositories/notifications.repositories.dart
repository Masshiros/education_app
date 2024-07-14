import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/notifications/domain/entities/notification.dart';


abstract interface class INotificationRepository {
  const INotificationRepository();
  ResultFuture<void> markAsRead(String notificationId);
  ResultFuture<void> clearAll();
  ResultFuture<void> clear(String notificationId);
  ResultFuture<void> sendNotification(Notification notification);
  ResultStream<List<Notification>> getNotifications();
}
