import 'package:abel_proj_01/shared/dark_them_prefs.dart';
import 'package:flutter/material.dart';

// import '../theme/services/dark_them_prefs.dart';

class DarkThemeProvider with ChangeNotifier {
  DarkThemePref darkThemePrefs = DarkThemePref();
  bool _darkTheme = false;
  bool get getDarkTheme => _darkTheme;

  set setDarkTheme(bool value) {
    _darkTheme = value;
    darkThemePrefs.setDarkTheme(value);
    notifyListeners();
  }
}
