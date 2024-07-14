import 'package:education_app/core/enums/notifications.enum.dart';

extension NotificationExtension on String {
  ENotification get toNotificationCategory {
    switch (this.toLowerCase()) {
      case 'test':
        return ENotification.TEST;
      case 'video':
        return ENotification.VIDEO;
      case 'material':
        return ENotification.MATERIAL;
      case 'course':
        return ENotification.COURSE;
      default:
        return ENotification.NONE;
    }
  }
}
