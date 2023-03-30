import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static Future<String?> getImagePath() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('imagePath');
  }

  static Future<void> saveImagePath(String path) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('imagePath', path);
  }
}