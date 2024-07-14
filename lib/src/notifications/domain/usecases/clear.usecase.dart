import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/notifications/domain/repositories/notifications.repositories.dart';

class ClearUseCase extends UsecaseWithParams<void, String> {
  const ClearUseCase(this._repo);
  final INotificationRepository _repo;

  @override
  ResultFuture<void> call(String params) async => _repo.clear(params);
}
