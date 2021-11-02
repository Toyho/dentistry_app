import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';

class RegistrationScreenViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _fb = FirebaseDatabase.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
      _fb.reference().child("users").child(user!.uid).set({
        'email': _userEmail,
        'password': passwordController.text,
        "registration date": formattedDate
      });
      notifyListeners();
    } else {
      _success = true;
      notifyListeners();
    }
  }

  void validationRegist() {
    if (passwordController.text == confirmPasswordController.text) {
      if (passwordController.text.length >= 6) {
        showSimpleNotification(
            Text("this is a message from simple notification"),
            background: Colors.green);
        Future.delayed(Duration(seconds: 1), () {
          register();
        });
      } else {

      }
    } else {

    }
  }

// notifyListeners();
}
