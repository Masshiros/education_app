import 'package:education_app/core/errors/exceptions.dart';
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
  Future<void> cacheFirstTimer() async {
    try {
      await _prefs.setBool(kFirstTimerKey, false);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<bool> checkIfUserIsFirstTimer() async {
    try {
      return await _prefs.getBool(kFirstTimerKey) ?? true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
