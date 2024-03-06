import 'package:firebase_auth/firebase_auth.dart';

abstract class Auth {
  Future<UserCredential> signInWithEmailAndPassword(String email, String password);
}

class FirebaseAuthService implements Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }
}
