import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static SharedPreferences? _preferences;

  static Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // String
  static Future<void> setString(String key, String value) async {
    await _preferences?.setString(key, value);
  }

  static String? getString(String key) {
    return _preferences?.getString(key);
  }

  // int
  static Future<void> setInt(String key, int value) async {
    await _preferences?.setInt(key, value);
  }

  static int? getInt(String key) {
    return _preferences?.getInt(key);
  }

  // double
  static Future<void> setDouble(String key, double value) async {
    await _preferences?.setDouble(key, value);
  }

  static double? getDouble(String key) {
    return _preferences?.getDouble(key);
  }

  // bool
  static Future<void> setBool(String key, bool value) async {
    await _preferences?.setBool(key, value);
  }

  static bool? getBool(String key) {
    return _preferences?.getBool(key);
  }

  // List<String>
  static Future<void> setStringList(String key, List<String> value) async {
    await _preferences?.setStringList(key, value);
  }

  static List<String>? getStringList(String key) {
    return _preferences?.getStringList(key);
  }

  // Remove
  static Future<void> remove(String key) async {
    await _preferences?.remove(key);
  }

  // Clear all
  static Future<void> clear() async {
    await _preferences?.clear();
  }
}
