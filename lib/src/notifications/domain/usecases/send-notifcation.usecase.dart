import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/notifications/domain/entities/notification.dart';
import 'package:education_app/src/notifications/domain/repositories/notifications.repositories.dart';

class SendNotificationUseCase extends UsecaseWithParams<void, Notification> {
  const SendNotificationUseCase(this._repo);
  final INotificationRepository _repo;

  @override
  ResultFuture<void> call(Notification params) async =>
      _repo.sendNotification(params);
}
