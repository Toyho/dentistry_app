// ignore_for_file: prefer_const_constructors
import 'package:dentistry_app/doctors_screen.dart';
import 'package:dentistry_app/login_screen.dart';
import 'package:dentistry_app/register_screen.dart';
import 'package:dentistry_app/resources/colors_res.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() {
    return _StartScreenState();
  }
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int _currentIndex = 0;

  void _onItemTipped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("AppBar"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: _currentIndex,
          children: const [
            RegisterScreen(),
            LoginScreen(),
            DoctorsScreen()
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration:
                  BoxDecoration(color: Color.fromRGBO(36, 137, 179, 1.0)),
              accountEmail: null,
              accountName: Text("Имя пациента"),
              currentAccountPicture: ClipOval(
                child: Image.network(
                  "https://i.pinimg.com/736x/ef/83/c3/ef83c388247b4c5784e2ae9cea604fd2.jpg",
                  fit: BoxFit.cover,
                  height: 150,
                  width: 150,
                ),
              ),
            ),
            Column(
              children: const [
                ListTile(
                  title: Text("История"),
                  leading: Icon(Icons.history),
                )
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: ColorsRes.fromHex(ColorsRes.whiteColor),
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Главная"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Сообщения"),
          BottomNavigationBarItem(icon: Icon(Icons.medical_services), label: "Врачи"),
        ],
        currentIndex: _currentIndex,
        onTap: _onItemTipped,
      ),
    );
  }
}
