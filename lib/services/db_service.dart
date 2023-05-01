import 'package:shared_preferences/shared_preferences.dart';

abstract class DB {
  static SharedPreferences? _prefs;

  static Future<void> initDB() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences get prefs => _prefs!;
}
