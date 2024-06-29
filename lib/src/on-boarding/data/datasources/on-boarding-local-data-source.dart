abstract class OnBoardingLocalDataSource {
  const OnBoardingLocalDataSource();

  Future<void> cacheFirstTimer();

  Future<bool> checkIfUserIsFirstTimer();
}