import 'package:flutter/material.dart';
import 'package:lock_unlock_gate/models/auth_model.dart';
import 'package:lock_unlock_gate/services/injector.dart';

class LoginScreenViewmodel extends ChangeNotifier {

  bool _passwordFieldObscureText = true;
  bool _loginButtonLoading = false;

  bool get passwordFieldObscureText => _passwordFieldObscureText;
  bool get loginButtonLoading => _loginButtonLoading;

  final _authModel = Injector.instance.locate<AuthModel>();

  Future<bool> validateLogin(String username, String password) async {
    _loginButtonLoading = true;
    notifyListeners();
    final success = await _authModel.doLogin(username, password);
    _loginButtonLoading = false;
    notifyListeners();
    return success;
  }

  void toggleObscurePassword() {
    _passwordFieldObscureText = !_passwordFieldObscureText;
    notifyListeners();
  }

}