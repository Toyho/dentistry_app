// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class AppointmentWithDoctor extends StatefulWidget {
  const AppointmentWithDoctor({Key? key}) : super(key: key);

  @override
  _AppointmentWithDoctorState createState() {
    return _AppointmentWithDoctorState();
  }
}

class _AppointmentWithDoctorState extends State<AppointmentWithDoctor> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 20.0),
              child: TextField(
                style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 18),
                // controller:
                // viewModel.passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Пароль",
                    hintStyle: TextStyle(
                        color: Colors.greenAccent),
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.lock,
                      color: Colors.greenAccent,
                    )),
              )),
          Container(
            child: Divider(
              color: Colors.greenAccent,
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
                    color: Colors.greenAccent,
                    fontSize: 18),
                // controller:
                // viewModel.passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Пароль",
                    hintStyle: TextStyle(
                        color: Colors.greenAccent),
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.lock,
                      color: Colors.greenAccent,
                    )),
              )),
          Container(
            child: Divider(
              color: Colors.greenAccent,
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
                    color: Colors.greenAccent,
                    fontSize: 18),
                // controller:
                // viewModel.passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Пароль",
                    hintStyle: TextStyle(
                        color: Colors.greenAccent),
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.lock,
                      color: Colors.greenAccent,
                    )),
              )),
          Container(
            child: Divider(
              color: Colors.greenAccent,
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
                    color: Colors.greenAccent,
                    fontSize: 18),
                // controller:
                // viewModel.passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Пароль",
                    hintStyle: TextStyle(
                        color: Colors.greenAccent),
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.lock,
                      color: Colors.greenAccent,
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
        ],
      ),
    );
  }
}