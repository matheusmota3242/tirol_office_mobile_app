import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
    }
  }

  Future logout(String email, String password) async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
    }
  }
}
