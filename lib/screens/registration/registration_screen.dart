// ignore_for_file: prefer_const_constructors
import 'package:dentistry_app/resources/colors_res.dart';
import 'package:dentistry_app/resources/images_res.dart';
import 'package:dentistry_app/screens/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'registration_screen_view_model.dart';


class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  RegistrationScreenViewModel viewModel = RegistrationScreenViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<RegistrationScreenViewModel>(
          builder: (context, viewModel, child) {
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
                                    style:
                                    Theme.of(context).textTheme.headline4!.copyWith(
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
                                      height: MediaQuery.of(context).size.height * 0.51,
                                      padding: EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(40.0)),
                                        gradient: LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                            Colors.white,
                                            ColorsRes.fromHex(ColorsRes.primaryColor),
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
                                                style: TextStyle(color: Colors.white, fontSize: 18),
                                                controller: viewModel.emailController,
                                                decoration: InputDecoration(
                                                    hintText: "Email",
                                                    hintStyle:
                                                    TextStyle(color: Colors.white),
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
                                                left: 20.0, right: 20.0, bottom: 10.0),
                                          ),
                                          Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.0),
                                              child: TextField(
                                                style: TextStyle(color: Colors.white, fontSize: 18),
                                                controller: viewModel.passwordController,
                                                obscureText: true,
                                                decoration: InputDecoration(
                                                    hintText: "Пароль",
                                                    hintStyle:
                                                    TextStyle(color: Colors.white),
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
                                                left: 20.0, right: 20.0, bottom: 10.0),
                                          ),
                                          Container(
                                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                                              child: TextField(
                                                controller: viewModel.confirmPasswordController,
                                                style: TextStyle(color: Colors.white, fontSize: 18),
                                                decoration: InputDecoration(
                                                    hintText: "Повторите пароль",
                                                    hintStyle: TextStyle(color: Colors.white),
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
                                            padding:
                                            EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
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
                                    height: MediaQuery.of(context).size.height * 0.54,
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: RaisedButton(
                                        padding: EdgeInsets.all(16.0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0)),
                                        color: Theme.of(context).primaryColor,
                                        textColor: Colors.white,
                                        child: Text("Зарегистрироваться"),
                                        onPressed: () async {
                                          viewModel.register();
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: FloatingActionButton(
                                  mini: true,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  backgroundColor: ColorsRes.fromHex(ColorsRes.primaryColor),
                                  child: Icon(Icons.arrow_back),
                                ),
                              ),
                            )
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
