import 'package:flutter/material.dart';
import 'package:lock_unlock_gate/services/component.dart';

class ThemeModel extends Component {
  // opcionalmente, todas as variáveis poderiam ser privadas apenas com get e na inicialização do model as cores poderiam
  // ser consultadas em um banco de dados
  
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  Color get staticColorText => Colors.white;
  Color get appBarColor => isDarkMode ? Colors.blue.shade800 : Colors.blue;
  Color get primaryTextColor => isDarkMode ? Colors.black : Colors.white;
  Color get secondaryColorText => isDarkMode ? Colors.white : Colors.black;
  Color get backgroundColor => isDarkMode ? Color(0xFF1A1A1A) : Color(0xBFECECEC);
  Color get loginBox => isDarkMode ? Color(0xFF242424) : Colors.white;


  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
  }
}
