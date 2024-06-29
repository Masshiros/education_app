import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/on-boarding/domain/repositories/on-boarding.repository.dart';

class CheckIfUserFirstTimerUseCase extends UsecaseWithoutParams {
  const CheckIfUserFirstTimerUseCase(this._repo);
  final IOnBoardingRepository _repo;
  @override
  ResultFuture<bool> call() async {
    return _repo.checkIfUserIsFirstTimer();
  }
}
