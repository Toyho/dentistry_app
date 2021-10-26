// ignore_for_file: prefer_const_constructors
import 'package:dentistry_app/screens/detail_info_doctor.dart';
import 'package:dentistry_app/screens/login_screen.dart';
import 'package:dentistry_app/screens/start_screen.dart';
import 'package:dentistry_app/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
  Widget _rightSideTransitionScreen(BuildContext context,
      Animation animation, Animation secondaryAnimation, Widget child) {
    const begin = Offset(-1.0, 0.0);
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
    return OverlaySupport.global(
      child: MaterialApp(
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
            case "logout":
              {
                return PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                  const LoginScreen(),
                  transitionDuration: Duration(milliseconds: 200),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                      _rightSideTransitionScreen(context, animation, secondaryAnimation, child),
                  settings: routeSettings,
                );
              }
          }
        },
      ),
    );
  }
}
