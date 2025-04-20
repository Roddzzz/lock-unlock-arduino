import 'package:firebase_auth/firebase_auth.dart';
import 'package:lock_unlock_gate/drivers/auth/auth_driver.dart';

class FirebaseAuthDriver extends AuthDriver {

  final _firebaseAuth = FirebaseAuth.instance;
  UserCredential? _userCredential;

  @override
  Future<bool> doLogin(String username, String password) async {
    if(username.isEmpty || password.isEmpty) {
      return false;
    }
    try {
      _userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: '${username}@fachinis.com', password: password);
      return true;
    } catch(error, stack_trace) {
      return false;
    }
  }

}