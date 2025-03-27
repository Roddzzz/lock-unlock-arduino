import 'package:flutter/material.dart';

class AppColors {
  static Color appBarColor = Colors.blue;
  static Color staticColorText = Colors.white;
  static Color primaryTextColor = Colors.white;
  static Color secondaryColorText = Colors.black;
  static Color backgroundColor = Color(0xBFECECEC);

  //Login
  static Color loginBox = Colors.white;

  // Método para alterar as cores com base no dark mode
  static void darkMode(bool isDarkMode) {
    if (isDarkMode) {
      // Cores para Dark Mode
      appBarColor = Colors.blue.shade900;
      primaryTextColor = Colors.black;
      secondaryColorText = Colors.white;
      backgroundColor = Color(0xFF1A1A1A);

      loginBox = Color(0xFF242424);
    } else {
      // Cores para Light Mode
      appBarColor = Colors.blue;
      primaryTextColor = Colors.white;
      secondaryColorText = Colors.black;
      backgroundColor = Color(0xBFECECEC);

      loginBox = Colors.white;
    }
  }
}
