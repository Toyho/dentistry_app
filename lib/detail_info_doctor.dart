// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailInfoDoctor extends StatefulWidget {
  String? index;

  DetailInfoDoctor({Key? key, this.index}) : super(key: key);

  @override
  _DetailInfoDoctorState createState() => _DetailInfoDoctorState(index);
}

class _DetailInfoDoctorState extends State<DetailInfoDoctor> {
  String? index;

  _DetailInfoDoctorState(this.index);

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
      body: Center(
        child: Hero(
          tag: 'image_doctor_$index',
          child: Image.network(
            "https://i.pinimg.com/736x/ef/83/c3/ef83c388247b4c5784e2ae9cea604fd2.jpg",
            fit: BoxFit.cover,
            height: 400,
            width: 370,
          ),
        ),
      ),
    );
  }
}