import 'package:flutter/material.dart';  // Importando o Provider
import 'app_routes.dart';  // Importando as rotas

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lock Unlock Arduino',
      initialRoute: 'loginScreen',
      routes: AppRoutes.routes,
    );
  }
}
