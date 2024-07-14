import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/notifications/repositories/notifications.repositories.dart';

class MarkAsReadUseCase extends UsecaseWithParams<void, String> {
  const MarkAsReadUseCase(this._repo);
  final INotificationRepository _repo;
  @override
  ResultFuture<void> call(String params) async => _repo.markAsRead(params);
}
