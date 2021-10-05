// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentistry_app/doctors.dart';
import 'package:dentistry_app/resources/images_res.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({Key? key}) : super(key: key);

  @override
  _DoctorsScreenState createState() {
    return _DoctorsScreenState();
  }
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final _database = FirebaseDatabase.instance.reference();

  void _activateListeners() {
    _database.child("doctors").onValue.listen((event) {
      dynamic value = event.snapshot.value;
      List<dynamic> doctors = value.map((i) => Doctors.fromJson(i)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                TabBar(
                  indicatorColor: Colors.white,
                  tabs: [
                    Tab(text: "Стоматологи"),
                    Tab(text: "Ортопеды"),
                  ],
                ),
              ],
            ),
          ),
          body: FutureBuilder(
            future: getData(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                print(snapshot.data);
                return TabBarView(
                  children: [
                    Dentists(),
                    Orthopedists(),
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.none) {
                return Text("No data");
              }
              return CircularProgressIndicator();
            },
          ),
        ));
  }

  Widget Dentists() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {
        return doctorCard(index);
      },
    );
  }

  Widget Orthopedists() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {
        return doctorCard(index);
      },
    );
  }

  Widget doctorCard(int index) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detail_info_doctor/$index');
      },
      child: Container(
          margin: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).primaryColor,
                    blurRadius: 20,
                    offset: Offset(0, 10))
              ]),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    bottomLeft: Radius.circular(24)),
                child: Hero(
                  tag: 'image_doctor_$index',
                  child: Image.network(
                    "https://i.pinimg.com/736x/ef/83/c3/ef83c388247b4c5784e2ae9cea604fd2.jpg",
                    fit: BoxFit.cover,
                    height: 160,
                    width: 130,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Hero(
                          tag: 'fio_doctor_$index',
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              "Иванов Иван Иванович",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: RichText(
                          text: TextSpan(
                        text: "Врач-стоматолог",
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                        children: const <TextSpan>[
                          TextSpan(text: "\nСтаж: 4 года"),
                        ],
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14, top: 8),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: RatingStars(
                          value: 4.6,
                          starBuilder: (index, color) => Icon(
                            Icons.star,
                            color: color,
                          ),
                          starCount: 5,
                          starSize: 20,
                          maxValue: 5,
                          starSpacing: 2,
                          maxValueVisibility: false,
                          valueLabelVisibility: false,
                          animationDuration: Duration(milliseconds: 1000),
                          starOffColor: const Color(0xffe7e8ea),
                          starColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Future<DocumentSnapshot> getData() async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection("doctors")
        .doc("1")
        .get();
  }
}
