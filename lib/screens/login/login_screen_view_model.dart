import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class LoginScreenViewModel extends ChangeNotifier {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late String _userEmail;
  late final User? user;

  bool isShowIndicator = false;

  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    isShowIndicator = true;
    notifyListeners();
    try
    {
      final User? user = (await _auth.signInWithEmailAndPassword(
        email: emailController.text.replaceAll(" ", ""),
        password: passwordController.text,
      ))
          .user;

      if (user != null) {
        _userEmail = user.email!;
        Future.delayed(Duration(seconds: 2), (){
          isShowIndicator = false;
          notifyListeners();
          Navigator.pushReplacementNamed(
              context, '/start_screen');
        });
      }
    }
    on Exception catch (_) {
      print(_);
      Future.delayed(const Duration(seconds: 2), (){
        isShowIndicator = false;
        notifyListeners();
      });
    } finally {
      // isShowIndicator = false;
      // notifyListeners();
    }


  }

// notifyListeners();
}