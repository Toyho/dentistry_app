// ignore_for_file: prefer_const_constructors
import 'package:dentistry_app/login_screen.dart';
import 'package:dentistry_app/start_screen.dart';
import 'package:dentistry_app/theme.dart';
import 'package:flutter/material.dart';

import 'detail_info_doctor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Widget _leftSideTransitionScreen(BuildContext context,
      Animation animation, Animation secondaryAnimation, Widget child) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    var curve = Curves.ease;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    final offsetAnimation = animation.drive(tween);
    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightThemeData(context),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        // '/start_screen': (context) => const StartScreen(),
        // '/detail_info_doctor': (context) => DetailInfoDoctor(),
      },
      onGenerateRoute: (routeSettings) {
        var path = routeSettings.name!.split('/');

        switch (path[1]) {
          case "detail_info_doctor":
            {
              return MaterialPageRoute(
                builder: (context) => DetailInfoDoctor(index: path[2]),
                settings: routeSettings,
              );
            }
          case "start_screen":
            {
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const StartScreen(),
                transitionDuration: Duration(milliseconds: 700),
                transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                  _leftSideTransitionScreen(context, animation, secondaryAnimation, child),
                settings: routeSettings,
              );
            }
        }
      },
    );
  }
}
