import 'package:lock_unlock_gate/services/service.dart';

class Injector {

  // criando singleton aqui


  static final Injector _instance = Injector._();

  static Injector get instance => _instance;

  Injector._();

  // fim da crianção do singleton


  final Set<Service> _services = {};

  void addServiceInstance(Service s) {
    _services.add(s);
  }

  T locate<T extends Service>() {
    return _services.whereType<T>().first;
  }



}