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

  late String _userEmail;
  late final User? user;

  bool isShowIndicator = false;
  late bool isErrorValidation;

  Future<void> register(BuildContext context) async {
    notifyListeners();
    try {
      user = (await _auth.createUserWithEmailAndPassword(
        email: emailController.text.replaceAll(" ", ""),
        password: passwordController.text,
      ))
          .user;
      if (user != null) {
        _userEmail = user!.email!;
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
        _fb.reference().child("users").child(user!.uid).set({
          'email': _userEmail,
          'password': passwordController.text,
          "registration date": formattedDate
        });
        isShowIndicator = false;
        notifyListeners();
        showSimpleNotification(const Text("Вы успешно зарегистрировались!"),
            background: Colors.lightGreen);
        Future.delayed(const Duration(milliseconds: 700), () => Navigator.pop(context));
      } else {
      notifyListeners();
      }
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          showSimpleNotification(const Text("The email address is badly formatted"),
              background: Colors.redAccent);
          break;
        case "user-not-found":
          showSimpleNotification(
              const Text(
                  "There is no user record corresponding to this identifier. The user may have been deleted"),
              background: Colors.redAccent);
          break;
        case "wrong-password":
          showSimpleNotification(
              const Text(
                  "The password is invalid or the user does not have a password"),
              background: Colors.redAccent);
          break;
        case "unknown":
          showSimpleNotification(Text(error.message!),
              background: Colors.redAccent);
          break;
      }
      isShowIndicator = false;
      notifyListeners();
    } finally {
      isShowIndicator = false;
      notifyListeners();
    }
  }

  void validationRegist(BuildContext context) {
    isShowIndicator = true;
    notifyListeners();
    isErrorValidation = false;
    if (passwordController.text != confirmPasswordController.text) {
      showSimpleNotification(Text("Пароли не совпадают"),
          background: Colors.redAccent);
      isErrorValidation = true;
    }
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
        register(context);
      });
    } else {
      isShowIndicator = false;
      notifyListeners();
    }
  }

  void validationRegistUnitTest() {
    isShowIndicator = true;
    notifyListeners();
    isErrorValidation = false;
    if (passwordController.text != confirmPasswordController.text) {
      isErrorValidation = true;
    }
    if (passwordController.text.length < 6) {
      isErrorValidation = true;
    }
    if (emailController.text.isEmpty) {
      isErrorValidation = true;
    }
    if (isErrorValidation) {
      isShowIndicator = false;
    }
  }

// notifyListeners();
}
