part of 'notifications-cubit.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

class NotificationsInitial extends NotificationsState {
  const NotificationsInitial();
}

class GettingNotifications extends NotificationsState {
  const GettingNotifications();
}

class SendingNotification extends NotificationsState {
  const SendingNotification();
}

class ClearingNotifications extends NotificationsState {
  const ClearingNotifications();
}
class NotificationsCleared extends NotificationsState {
  const NotificationsCleared();
}

class NotificationSent extends NotificationsState {
  const NotificationSent();
}

class NotificationsLoaded extends NotificationsState {
  const NotificationsLoaded(this.notifications);

  final List<Notification> notifications;

  @override
  List<Object> get props => notifications;
}

class NotificationError extends NotificationsState {
  const NotificationError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
