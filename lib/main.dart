import 'package:flutter/material.dart';
import 'app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lock Unlock Arduino',
        initialRoute: AppRoutes.loginPage,
        routes: AppRoutes.routes,
    );
  }
}