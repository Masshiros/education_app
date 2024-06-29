import 'package:bloc/bloc.dart';
import 'package:education_app/src/on-boarding/domain/usecases/cache-first-timer.usecase.dart';
import 'package:education_app/src/on-boarding/domain/usecases/check-if-user-first-timer.usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'on-boarding-state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit(
      {required cacheFirstTimerUseCase, required checkIfUserFirstTimerUseCase})
      : _cacheFirstTimerUseCase = cacheFirstTimerUseCase,
        _checkIfUserFirstTimerUseCase = checkIfUserFirstTimerUseCase,
        super(const OnBoardingInitial());

  final CacheFirstTimerUseCase _cacheFirstTimerUseCase;
  final CheckIfUserFirstTimerUseCase _checkIfUserFirstTimerUseCase;
  Future<void> cacheFirstTimerUseCase() async {
    emit(const CachingFirstTimer());
    final result = await _cacheFirstTimerUseCase();
    result.fold((l) => emit(OnBoardingError(l.errorMessage)),
        (r) => emit(const UserCached()));
  }

  Future<void> checkIfUserFirstTimerUseCase() async {
    emit(const CheckingIfUserIsFirstTimer());
    final result = await _checkIfUserFirstTimerUseCase();
    result.fold((l) => emit(const OnBoardingStatus(isFirstTimer: true)),
        (status) => emit(OnBoardingStatus(isFirstTimer: status)));
  }
}
