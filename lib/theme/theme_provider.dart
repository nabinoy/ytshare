import 'package:flutter/material.dart';
import 'package:ytshare/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }

  void darkTheme(bool data) {
    if (data) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
