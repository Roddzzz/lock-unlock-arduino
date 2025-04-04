import 'package:flutter/material.dart';
import 'package:lock_unlock_gate/screens/hub_management.dart';
import 'package:lock_unlock_gate/screens/lock_unlock_screen.dart';
import 'package:lock_unlock_gate/screens/login_screen.dart';

class AppRoutes {

  static Map<String, WidgetBuilder> get routes => {
    'loginScreen': (context) => LoginScreen(),
    'hubManagementScreen' : (context) => HubScreen(),
    'lockUnlockScreen': (context) => LockScreen(),
  };
}
