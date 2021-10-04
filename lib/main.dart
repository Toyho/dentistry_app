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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightThemeData(context),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/start_screen': (context) => const StartScreen(),
        // '/detail_info_doctor': (context) => DetailInfoDoctor(),
      },
      onGenerateRoute: (routeSettings) {
        var path = routeSettings.name!.split('/');

        if (path[1] == "detail_info_doctor") {
          return  MaterialPageRoute(
            builder: (context) => DetailInfoDoctor(index: path[2]),
            settings: routeSettings,
          );
        }
      },
    );
  }
}
