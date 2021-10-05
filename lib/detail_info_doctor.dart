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
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          snap: false,
          floating: false,
          expandedHeight: 160.0,
          centerTitle: true,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(140),
                  bottomRight: Radius.circular(140))),
          flexibleSpace: FlexibleSpaceBar(
            title: Hero(
                tag: 'fio_doctor_$index',
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    "Иванов Иван Иванович",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )),
            background: CircleAvatar(
              child: ClipOval(
                child: Hero(
                  tag: 'image_doctor_$index',
                  child: Image.network(
                    "https://i.pinimg.com/736x/ef/83/c3/ef83c388247b4c5784e2ae9cea604fd2.jpg",
                    fit: BoxFit.cover,
                    // height: 50,
                    // width: 50,
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                color: index.isOdd ? Colors.white : Colors.black12,
                height: 100.0,
                child: Center(
                  child: Text('$index', textScaleFactor: 5),
                ),
              );
            },
            childCount: 20,
          ),
        ),
      ],
    ));
  }
}
