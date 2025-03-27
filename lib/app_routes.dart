import 'package:flutter/material.dart';
import 'package:lock_unlock_gate/screens/lock_unlock_page.dart';
import 'package:lock_unlock_gate/screens/login_page.dart';

class AppRoutes {
  static const String loginPage = '/'; //Raiz do projeto, tela inicial do app
  static const String lockUnlockPage = '/lockUnlock';

  static Map<String, WidgetBuilder> get routes => {
    loginPage: (context) => LoginScreen(),
    lockUnlockPage: (context) => LockScreen(),
  };
}
