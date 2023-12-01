import 'package:shared_preferences/shared_preferences.dart';

class SharedService {
  static Future<void> shareInit() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTimeOpen = prefs.getBool('is_first_time_open') ?? true;

    if (isFirstTimeOpen) {
      await prefs.setBool('is_first_time_open', false);
    }
  }

  static Future<void> setThemeOrder(int data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    const keyName = 'themeOrder';
    final valueName = data;
    prefs.setInt(keyName, valueName);
  }

  static Future<int> getThemeOrder() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    const keyTheme = 'themeOrder';
    return prefs.getInt(keyTheme) ?? 1;
  }
}
