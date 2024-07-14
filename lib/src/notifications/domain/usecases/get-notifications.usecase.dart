import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/notifications/domain/entities/notification.dart';
import 'package:education_app/src/notifications/domain/repositories/notifications.repositories.dart';

class GetNotificationsUseCase
    extends StreamUsecaseWithoutParams<List<Notification>> {
  const GetNotificationsUseCase(this._repo);
  final INotificationRepository _repo;
  @override
  ResultStream<List<Notification>> call() => _repo.getNotifications();
}
