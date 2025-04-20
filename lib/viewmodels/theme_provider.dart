import 'package:flutter/material.dart';
import 'package:lock_unlock_gate/services/injector.dart';
import '../models/theme_model.dart';

class ThemeProvider extends ChangeNotifier {

  final _model = Injector.instance.locate<ThemeModel>();

  bool get isDarkMode => _model.isDarkMode;
  Color get staticColorText => _model.staticColorText;
  Color get appBarColor => _model.appBarColor;
  Color get primaryTextColor => _model.primaryTextColor;
  Color get secondaryColorText => _model.secondaryColorText;
  Color get backgroundColor => _model.backgroundColor;
  Color get loginBox => _model.loginBox;

  void toggleTheme() {
    _model.toggleDarkMode();
    notifyListeners();
  }
}
