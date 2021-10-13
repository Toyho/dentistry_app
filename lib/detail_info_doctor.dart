// ignore_for_file: prefer_const_constructors
import 'package:dentistry_app/resources/colors_res.dart';
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        color: ColorsRes.fromHex(ColorsRes.primaryColor),
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                children: <Widget>[
                  // Align(
                  //     alignment: Alignment.topLeft,
                  //     child: IconButton(
                  //       icon: Icon(Icons.arrow_back_ios),
                  //       color: ColorsRes.fromHex(ColorsRes.whiteColor),
                  //       onPressed: () {
                  //         Navigator.pop(context);
                  //       },
                  //     )),
                  Center(
                    child: Hero(
                      tag: 'image_doctor_$index',
                      child: CircleAvatar(
                        radius: 68,
                        backgroundColor:
                            ColorsRes.fromHex(ColorsRes.whiteColor),
                        child: CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              "https://i.pinimg.com/736x/ef/83/c3/ef83c388247b4c5784e2ae9cea604fd2.jpg"),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Hero(
                        tag: 'fio_doctor_$index',
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            "Иванов Иван Иванович",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: ColorsRes.fromHex(ColorsRes.whiteColor)),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            DraggableScrollableSheet(
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                      color: ColorsRes.fromHex(ColorsRes.whiteColor),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                            "В 2004 году повышала свою квалификацию на факультете последипломного образования "
                                "ГОУ ВПО КГМУ Минздрава России по эстетической терапии и медицинской косметологии "
                                "(свидетельство о повышении квалификации, г. Курск).")
                      ],
                    ),
                    controller: scrollController,
                  ),
                );
              },
              initialChildSize: 0.65,
              minChildSize: 0.65,
              maxChildSize: 1,
            )
          ],
        ),
      ),
    );
  }
}
