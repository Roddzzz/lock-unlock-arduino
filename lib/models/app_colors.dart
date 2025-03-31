import 'package:flutter/material.dart';

class AppColors {
  final bool isDarkMode;

  AppColors({required this.isDarkMode});
  Color get staticColorText => Colors.white;
  Color get appBarColor => isDarkMode ? Colors.blue.shade800 : Colors.blue;
  Color get primaryTextColor => isDarkMode ? Colors.black : Colors.white;
  Color get secondaryColorText => isDarkMode ? Colors.white : Colors.black;
  Color get backgroundColor => isDarkMode ? Color(0xFF1A1A1A) : Color(0xBFECECEC);
  Color get loginBox => isDarkMode ? Color(0xFF242424) : Colors.white;
}
