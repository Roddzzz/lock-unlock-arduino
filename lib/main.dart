import 'package:flutter/material.dart';  // Importando o Provider
import 'package:lock_unlock_gate/drivers/auth/firebase_auth_driver.dart';
import 'package:lock_unlock_gate/drivers/database/firebase_database_driver.dart';
import 'package:lock_unlock_gate/drivers/database/mappers/firebase_database_object_mapper_driver.dart';
import 'package:lock_unlock_gate/models/auth_model.dart';
import 'package:lock_unlock_gate/models/locks_model.dart';
import 'package:lock_unlock_gate/models/theme_model.dart';
import 'package:lock_unlock_gate/services/auth_service.dart';
import 'package:lock_unlock_gate/services/database_service.dart';
import 'package:lock_unlock_gate/services/injector.dart';
import 'app_routes.dart';  // Importando as rotas
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Injector.instance.addComponentInstance(ThemeModel());
  Injector.instance.addComponentInstance(FirebaseAuthDriver()); // se amanhã quiséssemos trocar o firebase por outro autenticador basta mudar aqui
  Injector.instance.addComponentInstance(AuthService()); // auth service precisa ser adicionado depois pois precisa do auth driver
  Injector.instance.addComponentInstance(AuthModel()); // auth model tem a inteligência de escolher se pergunta para o service ou se usa algo mockado
  Injector.instance.addComponentInstance(FirebaseDatabaseObjectMapperDriver());
  Injector.instance.addComponentInstance(FirebaseDatabaseDriver());
  Injector.instance.addComponentInstance(DatabaseService());
  Injector.instance.addComponentInstance(LocksModel());
  // opcionalmente poderíamos criar um factory para instanciar, injetar e deixar disponíveis todos esses beans
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lock Unlock Arduino',
      initialRoute: '/loginScreen',
      routes: AppRoutes.routes,
    );
  }
}
