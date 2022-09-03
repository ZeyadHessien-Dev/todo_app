import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setData({
    required String key,
    required dynamic value,
  }) async {
    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else if (value is double) {
      return await sharedPreferences.setDouble(key, value);
    } else if (value is String) {
      return await sharedPreferences.setString(key, value);
    }
    return await sharedPreferences.setBool(key, value);
  }

  static bool? getBoolData({
    required String key,
  }) {
    return sharedPreferences.getBool(key);
  }

  static String? getStringData({
    required String key,
  }) {
    return sharedPreferences.getString(key);
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences.remove(key);
  }
}
