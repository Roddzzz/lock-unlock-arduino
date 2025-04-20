import 'package:flutter/material.dart';  // Importando o Provider
import 'package:lock_unlock_gate/drivers/auth/firebase_auth_driver.dart';
import 'package:lock_unlock_gate/services/auth_service.dart';
import 'package:lock_unlock_gate/services/injector.dart';
import 'app_routes.dart';  // Importando as rotas
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Injector.instance.addServiceInstance(FirebaseAuthDriver()); // se amanhã quiséssemos trocar o firebase por outro autenticador basta mudar aqui
  Injector.instance.addServiceInstance(AuthService()); // auth service precisa ser adicionado depois pois precisa do auth driver
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
