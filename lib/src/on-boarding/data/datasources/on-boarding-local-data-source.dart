import 'package:shared_preferences/shared_preferences.dart';

abstract interface class IOnBoardingLocalDataSource {
  const IOnBoardingLocalDataSource();

  Future<void> cacheFirstTimer();

  Future<bool> checkIfUserIsFirstTimer();
}

const String kFirstTimerKey = 'first-timer';

class OnBoardingLocalDataSource implements IOnBoardingLocalDataSource {
  const OnBoardingLocalDataSource(this._prefs);
  final SharedPreferences _prefs;
  @override
  Future<void> cacheFirstTimer() {
    // TODO: implement cacheFirstTimer
    throw UnimplementedError();
  }

  @override
  Future<bool> checkIfUserIsFirstTimer() {
    // TODO: implement checkIfUserIsFirstTimer
    throw UnimplementedError();
  }
}
