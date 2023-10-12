import 'package:firebase_auth/firebase_auth.dart';

import '../model/UserModel.dart';


class UserController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User> signUp(UserModel user) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      return userCredential.user;
    } catch (e) {
      print('Error during signup: $e');
      return null;
    }
  }
}
