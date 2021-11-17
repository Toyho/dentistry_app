import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreenViewModel extends ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  late final FirebaseAuth _auth;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late String _userEmail;
  late final User? user;
  late bool isErrorValidation;
  bool isShowIndicator = false;

  Future<void> initState(BuildContext context) async {
    await Firebase.initializeApp();
    _auth = FirebaseAuth.instance;
    final SharedPreferences prefs = await _prefs;
    if (prefs.getString('uid_account') != null) {
      Navigator.pushReplacementNamed(context, '/start_screen');
    }
  }

  void validationAuth(BuildContext context) {
    isErrorValidation = false;
    if (passwordController.text.length < 6) {
      showSimpleNotification(Text("Пароль должен быть больше 6 знаков"),
          background: Colors.redAccent);
      isErrorValidation = true;
    }
    if (emailController.text.isEmpty) {
      showSimpleNotification(Text("Введите Вашу электронную почту"),
          background: Colors.redAccent);
      isErrorValidation = true;
    }
    if (!isErrorValidation) {
      Future.delayed(Duration(seconds: 1), () {
        signInWithEmailAndPassword(context);
      });
    }
  }

  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    final SharedPreferences prefs = await _prefs;
    isShowIndicator = true;
    notifyListeners();
    try {
      final User? user = (await _auth.signInWithEmailAndPassword(
        email: emailController.text.replaceAll(" ", ""),
        password: passwordController.text,
      ))
          .user;

      if (user != null) {
        _userEmail = user.email!;
        prefs.setString("uid_account", user.uid);
        Future.delayed(Duration(seconds: 2), () {
          isShowIndicator = false;
          notifyListeners();
          Navigator.pushReplacementNamed(context, '/start_screen');
        });
      }
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          showSimpleNotification(Text("The email address is badly formatted"),
              background: Colors.redAccent);
          break;
        case "user-not-found":
          showSimpleNotification(
              Text(
                  "There is no user record corresponding to this identifier. The user may have been deleted"),
              background: Colors.redAccent);
          break;
        case "wrong-password":
          showSimpleNotification(
              Text(
                  "The password is invalid or the user does not have a password"),
              background: Colors.redAccent);
          break;
        case "unknown":
          showSimpleNotification(Text(error.message!),
              background: Colors.redAccent);
          break;
      }
      Future.delayed(const Duration(seconds: 2), () {
        isShowIndicator = false;
        notifyListeners();
      });
    } finally {
      isShowIndicator = false;
      // notifyListeners();
    }
  }

// notifyListeners();
}
