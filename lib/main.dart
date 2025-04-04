import 'package:flutter/material.dart';
import 'package:provider/provider.dart';  // Importando o Provider
import 'app_routes.dart';  // Importando as rotas
import 'models/theme_provider.dart';  // Importando o ThemeProvider

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),  // Criando e fornecendo o ThemeProvider
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
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
