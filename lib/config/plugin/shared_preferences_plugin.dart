import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesPlugin {
  static Future<SharedPreferences> _getPreferences() async {
    return await SharedPreferences.getInstance();
  }

  static Future<void> setBool(String key, bool value) async {
    final preferences = await _getPreferences();

    await preferences.setBool(key, value);
  }

  static Future<bool?> getBool(String key) async {
    final preferences = await _getPreferences();
    return preferences.getBool(key);
  }
}
