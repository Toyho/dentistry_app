import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RegistrationScreenViewModel extends ChangeNotifier {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _fb = FirebaseDatabase.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  late bool _success;
  late String _userEmail;
  late final User? user;

  Future<void> register() async {
    user = (await _auth.createUserWithEmailAndPassword(
      email: emailController.text.replaceAll(" ", ""),
      password: passwordController.text,
    ))
        .user;
    if (user != null) {
      _success = true;
      _userEmail = user!.email!;
      _fb
          .reference()
          .child("users")
          .child(user!.uid)
          .set({'email': _userEmail, 'password': passwordController.text});
      notifyListeners();
    } else {
      _success = true;
      notifyListeners();
    }
  }
// notifyListeners();
}