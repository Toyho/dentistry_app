// ignore_for_file: prefer_const_constructors
import 'package:dentistry_app/models/push_notification.dart';
import 'package:dentistry_app/screens/doctors_screen.dart';
import 'package:dentistry_app/resources/colors_res.dart';
import 'package:dentistry_app/screens/technical_work.dart';
import 'package:dentistry_app/widgets/message_notification.dart';
import 'package:dentistry_app/widgets/oval_right_clipper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import 'main_screen.dart';

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
    registerNotification();
    checkForInitialMessage();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
      );
      setState(() {
        _notificationInfo = notification;
        _totalNotifications++;
      });
    });
  }

  int _currentIndex = 0;

  List<String> listBottomBar = ["Главная", "Сообщения", "Врачи"];

  PageController pageController = PageController();

  late final FirebaseMessaging _messaging;
  int _totalNotifications = 0;
  PushNotification? _notificationInfo;

  Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
  }

  void registerNotification() async {
    _messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
        );

        setState(() {
          _notificationInfo = notification;
          _totalNotifications++;
        });
        if (_notificationInfo != null) {
          showOverlayNotification((context) {
            return MessageNotification(
              message: 'i love you',
              onReplay: () {
                OverlaySupportEntry.of(context)!
                    .dismiss(); //use OverlaySupportEntry to dismiss overlay
                toast('you checked this message');
              },
            );
          });
        }
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  checkForInitialMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
      );
      setState(() {
        _notificationInfo = notification;
        _totalNotifications++;
      });
    }
  }

  void _onItemTipped(int index) {
    setState(() {
      _currentIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(listBottomBar[_currentIndex]),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: const [MainScreen(), TechnicalWork(), DoctorsScreen()],
      ),
      // SafeArea(
      //   top: false,
      //   child: IndexedStack(
      //     index: _currentIndex,
      //     children: const [
      //       MainScreen(),
      //       TechnicalWork(),
      //       DoctorsScreen()
      //     ],
      //   ),
      // ),
      drawer: _buildDrawer(context),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: ColorsRes.fromHex(ColorsRes.whiteColor),
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Главная"),
          BottomNavigationBarItem(
              icon: Icon(Icons.message), label: "Сообщения"),
          BottomNavigationBarItem(
              icon: Icon(Icons.medical_services), label: "Врачи"),
        ],
        currentIndex: _currentIndex,
        onTap: _onItemTipped,
      ),
    );
  }
}

_buildDrawer(BuildContext context) {
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
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/logout', (r) => false);
                    },
                  ),
                ),
                Container(
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
                    backgroundImage: NetworkImage(
                        "https://i.pinimg.com/736x/ef/83/c3/ef83c388247b4c5784e2ae9cea604fd2.jpg"),
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
