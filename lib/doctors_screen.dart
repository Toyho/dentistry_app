import 'package:flutter/material.dart';

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
  }

  @override
  void dispose() {
    super.dispose();
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
                  tabs: [
                    Tab(text: "Стоматологи"),
                    Tab(text: "Артопеды"),
                  ],
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
            ],
          ),
        ));
  }
}