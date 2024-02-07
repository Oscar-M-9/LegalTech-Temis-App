import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  // ThemeData _themeData = ThemeData.light();

  // ThemeData get themeData => _themeData;

  // void setThemeData(ThemeData themeData) {
  //   _themeData = themeData;
  //   notifyListeners();
  // }

  // ThemeMode _themeMode = ThemeMode.light;
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
