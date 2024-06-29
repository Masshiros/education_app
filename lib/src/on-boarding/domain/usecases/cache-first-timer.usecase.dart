import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/on-boarding/domain/repositories/on-boarding.repository.dart';

class CacheFirstTimerUseCase extends UsecaseWithoutParams {
  const CacheFirstTimerUseCase(this._repo);
  final IOnBoardingRepository _repo;
  @override
  ResultFuture<void> call() {
    return _repo.cacheFirstTimer();
  }
}
