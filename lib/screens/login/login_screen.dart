// ignore_for_file: prefer_const_constructors
import 'package:dentistry_app/resources/colors_res.dart';
import 'package:dentistry_app/resources/images_res.dart';
import 'package:dentistry_app/screens/login/login_screen_view_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginScreenViewModel viewModel = LoginScreenViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child:
          Consumer<LoginScreenViewModel>(builder: (context, viewModel, child) {
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
                body: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Text(
                                "Dentistry",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                              )),
                        ),
                        Container(
                          padding: EdgeInsets.all(20.0),
                          child: Stack(
                            children: <Widget>[
                              ClipPath(
                                clipper: RoundedDiagonalPathClipper(),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.51,
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40.0)),
                                    gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Colors.white,
                                        ColorsRes.fromHex(
                                            ColorsRes.primaryColor),
                                      ],
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 90.0,
                                      ),
                                      Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: TextField(
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                            controller:
                                                viewModel.emailController,
                                            decoration: InputDecoration(
                                                hintText: "Email",
                                                hintStyle: TextStyle(
                                                    color: Colors.white),
                                                border: InputBorder.none,
                                                icon: Icon(
                                                  Icons.email,
                                                  color: Colors.white,
                                                )),
                                          )),
                                      Container(
                                        child: Divider(
                                          color: Colors.white,
                                        ),
                                        padding: EdgeInsets.only(
                                            left: 20.0,
                                            right: 20.0,
                                            bottom: 10.0),
                                      ),
                                      Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: TextField(
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                            controller:
                                                viewModel.passwordController,
                                            obscureText: true,
                                            decoration: InputDecoration(
                                                hintText: "Пароль",
                                                hintStyle: TextStyle(
                                                    color: Colors.white),
                                                border: InputBorder.none,
                                                icon: Icon(
                                                  Icons.lock,
                                                  color: Colors.white,
                                                )),
                                          )),
                                      Container(
                                        child: Divider(
                                          color: Colors.white,
                                        ),
                                        padding: EdgeInsets.only(
                                            left: 20.0,
                                            right: 20.0,
                                            bottom: 10.0),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20.0),
                                        child: Align(
                                            alignment: Alignment.centerRight,
                                            child: GestureDetector(
                                              onTap: () {},
                                              child: Text(
                                                "Забыли пароль?",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                            )),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  radius: 70.0,
                                  backgroundColor: Colors.transparent,
                                  child: Image.asset(
                                    ImageRes.mainLogo,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.54,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: AnimatedContainer(
                                    width: viewModel.isShowIndicator ? 48 : 170,
                                    height: 48,
                                    duration: Duration(milliseconds: 300),
                                    child: RaisedButton(
                                      padding: EdgeInsets.all(16.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0)),
                                      color: Theme.of(context).primaryColor,
                                      textColor: Colors.white,
                                      child: viewModel.isShowIndicator
                                          ? SizedBox(
                                              height: 48,
                                              width: 48,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(Colors.white),
                                                value: null,
                                                strokeWidth: 1.0,
                                              ),
                                            )
                                          : Text("Авторизироваться"),
                                      onPressed: () async {
                                        await viewModel
                                            .signInWithEmailAndPassword(context);
                                        // Navigator.pushReplacementNamed(
                                        //     context, '/start_screen');
                                      },
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Нет аккаунта?",
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(width: 10.0),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, "/registration_screen");
                                },
                                child: Text(
                                  "Зарегистрируйтесь",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
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
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class RoundedDiagonalPathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0.0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0.0)
      ..quadraticBezierTo(size.width, 0.0, size.width - 20.0, 0.0)
      ..lineTo(40.0, 70.0)
      ..quadraticBezierTo(10.0, 85.0, 0.0, 120.0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
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
