import 'package:lock_unlock_gate/services/component.dart';

class Injector {

  // criando singleton aqui


  static final Injector _instance = Injector._();

  static Injector get instance => _instance;

  Injector._();

  // fim da crianção do singleton


  final Set<Component> _components = {};

  void addComponentInstance(Component s) {
    _components.add(s);
  }

  T locate<T extends Component>() {
    return _components.whereType<T>().first;
  }



}