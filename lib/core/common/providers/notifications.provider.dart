import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationNotifier extends ChangeNotifier {
  NotificationNotifier(this._prefs) {
    _muteNotifications = _prefs.getBool(key) ?? false;
  }
  static const key = 'muteNotifications';

  final SharedPreferences _prefs;
  late bool _muteNotifications;
  bool get muteNotifications => _muteNotifications;
  void enableNotificationSounds() {
    _muteNotifications = false;
    _prefs.setBool(key, false);
    notifyListeners();
  }

  void disableNotificationSounds() {
    _muteNotifications = true;
    _prefs.setBool(key, true);
    notifyListeners();
  }

  void toggleMuteNotifications() {
    _muteNotifications = !_muteNotifications;
    _prefs.setBool(key, _muteNotifications);
    notifyListeners();
  }
}
