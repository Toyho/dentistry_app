// ignore_for_file: prefer_const_constructors
import 'package:dentistry_app/screens/appointmentWithDoctor/appointment_with_doctor.dart';
import 'package:dentistry_app/screens/doctors/doctorsList/doctors_screen.dart';
import 'package:dentistry_app/resources/colors_res.dart';
import 'package:dentistry_app/screens/startScreen/start_screen_view_model.dart';
import 'package:dentistry_app/screens/technical_work.dart';
import 'package:dentistry_app/widgets/oval_right_clipper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() {
    return _StartScreenState();
  }
}

class _StartScreenState extends State<StartScreen> {
  StartScreenViewModel viewModel = StartScreenViewModel();

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    viewModel.initViewModel(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Consumer<StartScreenViewModel>(
            builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              title: Text(viewModel.listBottomBar[viewModel.currentIndex]),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            body: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: viewModel.pageController,
              children: const [
                MainScreen(),
                TechnicalWork(),
                AppointmentWithDoctor(),
                TechnicalWork(),
                DoctorsScreen()
              ],
            ),
            drawer: _buildDrawer(context, viewModel),
            bottomNavigationBar: BottomNavigationBar(
              selectedFontSize: 12,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Theme.of(context).primaryColor,
              selectedItemColor: ColorsRes.fromHex(ColorsRes.whiteColor),
              showUnselectedLabels: false,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: "Главная"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.message), label: "Сообщения"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.add_circle), label: "Записаться"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.list_alt), label: "Мои записи"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.medical_services), label: "Врачи"),
              ],
              currentIndex: viewModel.currentIndex,
              onTap: viewModel.onItemTipped,
            ),
          );
        }));
  }
}

_buildDrawer(BuildContext context, StartScreenViewModel viewModel) {
  return ClipPath(
    clipper: OvalRightBorderClipper(),
    child: Drawer(
      child: Container(
        padding: const EdgeInsets.only(left: 16.0, right: 40),
        decoration: BoxDecoration(
            color: ColorsRes.fromHex(ColorsRes.primaryColor),
            boxShadow: const [BoxShadow(color: Colors.black45)]),
        width: 300,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.logout,
                      color: ColorsRes.fromHex(ColorsRes.whiteColor),
                    ),
                    onPressed: () {
                      viewModel.logout(context);
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/logout', (r) => false);
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () async => viewModel.pickImageFromGallery(context),
                  child: Container(
                    height: 110,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(colors: [
                          ColorsRes.fromHex(ColorsRes.whiteColor),
                          ColorsRes.fromHex(ColorsRes.primaryColor)
                        ])),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: viewModel.croppedImage == null
                          ? NetworkImage(
                              "https://i.pinimg.com/736x/ef/83/c3/ef83c388247b4c5784e2ae9cea604fd2.jpg")
                          : FileImage(viewModel.croppedImage!) as ImageProvider,
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  "Имя Фамилия",
                  style: TextStyle(
                      color: ColorsRes.fromHex(ColorsRes.whiteColor),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "электронный_адрес@gmail.com",
                  style: TextStyle(
                      color: ColorsRes.fromHex(ColorsRes.whiteColor),
                      fontSize: 16.0),
                ),
                SizedBox(height: 30.0),
                _buildRow(Icons.person_pin, "Мой профиль"),
                _buildDivider(),
                _buildRow(Icons.notifications, "Оповещения", showBadge: true),
                _buildDivider(),
                _buildRow(Icons.settings, "Настройки"),
                _buildDivider(),
                _buildRow(Icons.info_outline, "Помощь"),
                _buildDivider(),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Divider _buildDivider() {
  return Divider(
    color: Colors.white,
  );
}

Widget _buildRow(IconData icon, String title,
    {bool showBadge = false, Function()? actionOnTab}) {
  final TextStyle tStyle =
      TextStyle(color: ColorsRes.fromHex(ColorsRes.whiteColor), fontSize: 16.0);
  return InkWell(
    onTap: actionOnTab ?? () {},
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(children: [
        Icon(
          icon,
          color: ColorsRes.fromHex(ColorsRes.whiteColor),
        ),
        SizedBox(width: 10.0),
        Text(
          title,
          style: tStyle,
        ),
        Spacer(),
        if (showBadge)
          Material(
            color: Colors.deepOrange,
            elevation: 5.0,
            shadowColor: Colors.red,
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
              width: 25,
              height: 25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                "10+",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
      ]),
    ),
  );
}
