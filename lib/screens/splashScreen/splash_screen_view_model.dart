import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenViewModel extends ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> initState(BuildContext context) async {
    final SharedPreferences prefs = await _prefs;
    Future.delayed(const Duration(seconds: 2), () {
      if (prefs.getString('uid_account') != null) {
        Navigator.pushReplacementNamed(context, '/start_screen');
      } else {
        Navigator.pushReplacementNamed(context, '/login_screen');
      }
    });
  }

// notifyListeners();
}
