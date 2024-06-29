part of 'on-boarding-cubit.dart';

@immutable
abstract class OnBoardingState extends Equatable {
  const OnBoardingState();
  @override
  List<Object> get props => [];
}

class OnBoardingInitial extends OnBoardingState {
  const OnBoardingInitial();
}

class CachingFirstTimer extends OnBoardingState {
  const CachingFirstTimer();
}

class CheckingIfUserIsFirstTimer extends OnBoardingState {
  const CheckingIfUserIsFirstTimer();
}

class UserCached extends OnBoardingState {
  const UserCached();
}

class OnBoardingStatus extends OnBoardingState {
  const OnBoardingStatus({required this.isFirstTimer});
  final bool isFirstTimer;
  @override
  List<bool> get props => [isFirstTimer];
}

class OnBoardingError extends OnBoardingState {
  const OnBoardingError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}
