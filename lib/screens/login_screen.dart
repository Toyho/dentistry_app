// ignore_for_file: prefer_const_constructors
import 'package:dentistry_app/resources/images_res.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final fb = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    final ref = fb.reference();
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: RPSCustomPainter(),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: ListView(
              children: [
                Image.asset(
                  ImageRes.mainLogo,
                  height: 150,
                  width: 150,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(
                        "Dentistry",
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                      )),
                ),
                Container(
                  margin: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.0),
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).primaryColor,
                            blurRadius: 30,
                            offset: Offset(0, 10))
                      ]),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        "Войдите в свой аккаунт",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Email",
                            focusColor: Theme.of(context).primaryColor),
                      ),
                      SizedBox(height: 10.0),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Пароль",
                            focusColor: Theme.of(context).primaryColor),
                      ),
                      SizedBox(height: 10.0),
                      Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {},
                            child: Text(
                              "Забыли пароль?",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          )),
                      SizedBox(height: 20.0),
                      RaisedButton(
                        padding: EdgeInsets.all(16.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        child: Text("Авторизироваться"),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/start_screen');
                        },
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "Или авторизироваться с помощью:",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: SvgPicture.asset(ImageRes.facebookLogo),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: SvgPicture.asset(ImageRes.twitterLogo),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: SvgPicture.asset(ImageRes.vkLogo),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Нет аккаунта?"),
                      SizedBox(width: 10.0),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Зарегистрируйтесь",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint_0.shader = ui.Gradient.linear(
        Offset(size.width * 0.64, size.height * 0.11),
        Offset(size.width, size.height * 0.11),
        [Color(0x5551a7e1), Color(0x99307189)],
        [0.00, 1.00]);

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.64, 0);
    path_0.quadraticBezierTo(size.width * 0.74, size.height * 0.09,
        size.width * 0.79, size.height * 0.08);
    path_0.cubicTo(size.width * 0.74, size.height * 0.09, size.width * 0.69,
        size.height * 0.14, size.width * 0.71, size.height * 0.17);
    path_0.quadraticBezierTo(size.width * 0.72, size.height * 0.19,
        size.width * 0.79, size.height * 0.21);
    path_0.quadraticBezierTo(
        size.width * 0.93, size.height * 0.24, size.width, size.height * 0.21);
    path_0.quadraticBezierTo(size.width, size.height * 0.16, size.width, 0);
    path_0.lineTo(size.width * 0.64, 0);
    path_0.close();

    canvas.drawPath(path_0, paint_0);

    Paint paint_1 = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint_1.shader = ui.Gradient.linear(
        Offset(size.width * 0.64, size.height * 0.12),
        Offset(size.width, size.height * 0.12),
        [Color(0x6a468ade), Color(0x870a5eb7)],
        [0.00, 1.00]);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.64, size.height * 0.08);
    path_1.quadraticBezierTo(size.width * 0.68, size.height * 0.15,
        size.width * 0.76, size.height * 0.13);
    path_1.cubicTo(size.width * 0.81, size.height * 0.15, size.width * 0.71,
        size.height * 0.22, size.width * 0.74, size.height * 0.24);
    path_1.quadraticBezierTo(
        size.width * 0.81, size.height * 0.27, size.width, size.height * 0.18);
    path_1.lineTo(size.width, 0);
    path_1.quadraticBezierTo(size.width * 0.83, 0, size.width * 0.77, 0);
    path_1.quadraticBezierTo(size.width * 0.66, size.height * 0.02,
        size.width * 0.64, size.height * 0.08);
    path_1.close();

    canvas.drawPath(path_1, paint_1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
