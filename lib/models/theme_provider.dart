import 'package:flutter/material.dart';
import 'app_colors.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  AppColors get appColors => AppColors(isDarkMode: _isDarkMode);
}
