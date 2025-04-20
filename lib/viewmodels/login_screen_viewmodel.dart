import 'package:flutter/material.dart';

class LoginScreenViewmodel extends ChangeNotifier {

  bool _passwordFieldObscureText = true;
  bool _loginButtonLoading = false;

  bool get passwordFieldObscureText => _passwordFieldObscureText;
  bool get loginButtonLoading => _loginButtonLoading;

  Future<bool> validateLogin(String username, String password) async {
    _loginButtonLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    _loginButtonLoading = false;
    notifyListeners();
    return false;
  }

  void toggleObscurePassword() {
    _passwordFieldObscureText = !_passwordFieldObscureText;
    notifyListeners();
  }

}