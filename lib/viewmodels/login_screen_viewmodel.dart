import 'package:flutter/material.dart';

class LoginScreenViewmodel extends ChangeNotifier {

  bool _passwordFieldObscureText = false;

  bool get passwordFieldObscureText => _passwordFieldObscureText;

  Future<bool> validateLogin(String username, String password) async {
    return false;
  }

  void toggleObscurePassword() {
    _passwordFieldObscureText = !_passwordFieldObscureText;
    notifyListeners();
  }

}