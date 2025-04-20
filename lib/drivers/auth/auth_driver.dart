import 'package:lock_unlock_gate/drivers/driver.dart';

abstract class AuthDriver extends Driver {

  Future<bool> doLogin(String username, String password);
}