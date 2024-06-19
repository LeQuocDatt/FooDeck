import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  static ThemeData themeData = ThemeData.light();

  static void toggleTheme() {
    if (themeData == ThemeData.light()) {
      themeData = ThemeData.dark();
    } else {
      themeData = ThemeData.light();
    }
  }

  @override
  void notifyListeners() {
    toggleTheme();
    super.notifyListeners();
  }
}
