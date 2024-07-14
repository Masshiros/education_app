import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/notifications/repositories/notifications.repositories.dart';

class ClearAllUseCase extends UsecaseWithoutParams<void> {
  const ClearAllUseCase(this._repo);
  final INotificationRepository _repo;
  @override
  ResultFuture<void> call() async => _repo.clearAll();
}
