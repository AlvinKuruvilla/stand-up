import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  static bool _isDark = false;
  ThemeMode currentTheme() {
    return _isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}
