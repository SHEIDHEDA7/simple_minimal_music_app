import 'package:flutter/material.dart';
import 'package:music_app/themes/dark_mode.dart';
import 'package:music_app/themes/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  // Initially light mode-
  ThemeData _themeData = lightMode;

  // Getting theme
  ThemeData get themeData => _themeData;
  // While setting/changing always do it to t not _ and while checking _

  bool get isDarkMode => _themeData == darkMode;

  // Set theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;

    // Updates UI
    notifyListeners();
  }

  void changeTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
