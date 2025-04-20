import 'package:flutter/material.dart';
import 'package:lock_unlock_gate/models/theme_provider.dart';
import 'package:lock_unlock_gate/screens/hub_management.dart';
import 'package:lock_unlock_gate/screens/lock_unlock_screen.dart';
import 'package:lock_unlock_gate/screens/login_screen.dart';
import 'package:lock_unlock_gate/viewmodels/hub_screen_viewmodel.dart';
import 'package:lock_unlock_gate/viewmodels/lock_screen_viewmodel.dart';
import 'package:lock_unlock_gate/viewmodels/login_screen_viewmodel.dart';
import 'package:provider/provider.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> get routes => {
    '/loginScreen':
        (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (ctx) => LoginScreenViewmodel()),
            ChangeNotifierProvider(create: (ctx) => ThemeProvider()),
          ],
          child: LoginScreen(),
        ),
    '/hubManagementScreen':
        (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (ctx) => ThemeProvider()),
            ChangeNotifierProvider(create: (ctx) => HubScreenViewmodel()),
          ],
          child: HubScreen(),
        ),
    '/lockUnlockScreen': (context) => MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ThemeProvider()),
        ChangeNotifierProvider(create: (ctx) => LockScreenViewmodel())
      ],
      child: LockScreen(),
    ),
  };
}
