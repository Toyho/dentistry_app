// ignore_for_file: prefer_const_constructors
import 'package:dentistry_app/resources/colors_res.dart';
import 'package:dentistry_app/resources/images_res.dart';
import 'package:flutter/material.dart';

class TechnicalWork extends StatefulWidget {
  const TechnicalWork({Key? key}) : super(key: key);

  @override
  State<TechnicalWork> createState() => _TechnicalWorkState();
}

class _TechnicalWorkState extends State<TechnicalWork> with AutomaticKeepAliveClientMixin<TechnicalWork> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(ImageRes.technicalWork),
        Text("Ведутся технические работы",
            style: TextStyle(
              color: ColorsRes.fromHex(ColorsRes.primaryColor),
              fontSize: 23,
              fontWeight: FontWeight.bold,
            )),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
