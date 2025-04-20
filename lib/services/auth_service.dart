import 'package:lock_unlock_gate/drivers/auth/auth_driver.dart';
import 'package:lock_unlock_gate/services/injector.dart';
import 'package:lock_unlock_gate/services/service.dart';

class AuthService extends Service {

  final _driver = Injector.instance.locate<AuthDriver>();


  Future<bool> doLogin(String username, String password) => _driver.doLogin(username, password);
}