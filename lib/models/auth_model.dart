import 'package:lock_unlock_gate/services/auth_service.dart';
import 'package:lock_unlock_gate/services/component.dart';
import 'package:lock_unlock_gate/services/injector.dart';

class AuthModel extends Component {

  final _authService = Injector.instance.locate<AuthService>();

  Future<bool> doLogin(String username, String password) => _authService.doLogin(username, password);
}