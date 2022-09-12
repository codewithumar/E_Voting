import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static late SharedPreferences _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future storeURL(String key, String fileURL) async {
    await _preferences.setString(key, fileURL);
  }

  static String? getURL(String key) {
    return _preferences.getString(key);
  }
}
