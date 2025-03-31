import 'package:flutter/material.dart';
import 'package:lock_unlock_gate/screens/lock_unlock_screen.dart';
import 'package:lock_unlock_gate/screens/login_screen.dart';

class AppRoutes {
  static const String loginScreen = '/'; //Raiz do projeto, tela inicial do app
  static const String lockUnlockScreen = '/lockUnlock';

  static Map<String, WidgetBuilder> get routes => {
    loginScreen: (context) => LoginScreen(),
    lockUnlockScreen: (context) => LockScreen(),
  };
}
