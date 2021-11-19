import 'dart:io';

import 'package:dentistry_app/models/push_notification.dart';
import 'package:dentistry_app/resources/colors_res.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class StartScreenViewModel extends ChangeNotifier {

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  DatabaseReference? database = FirebaseDatabase.instance.reference();


  int currentIndex = 0;
  List<String> listBottomBar = ["Главная", "Сообщения", "Записаться на приём", "Мои записи", "Врачи"];
  PageController pageController = PageController();
  late final FirebaseMessaging _messaging;
  int totalNotifications = 0;
  PushNotification? notificationInfo;
  String? uid_account;

  ImagePicker picker = ImagePicker();
  File? imagePick;
  File? croppedImage;

  void initViewModel(BuildContext context) async {
    await Firebase.initializeApp();
    final SharedPreferences prefs = await _prefs;
    uid_account = prefs.getString('uid_account');
    Future.delayed(const Duration(seconds: 10), () {
      flutterLocalNotificationsPlugin.show(
          12,
          "Привет!",
          "Это тестовое локальное оповещение, которое показывается через 10 секунд после авторизации",
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher',
            ),
          ));
    });
    registerNotification();
    checkForInitialMessage();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title as String),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body as String)],
                  ),
                ),
              );
            });
      }
    });
  }
  
  Future<void> pickImageFromGallery(BuildContext context) async {
    final XFile? pickerFile = await picker.pickImage(source: ImageSource.gallery);
    imagePick = File(pickerFile!.path);

    croppedImage = await ImageCropper.cropImage(
      sourcePath: imagePick!.path,
      maxWidth: 1080,
      maxHeight: 1080,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Редактирование',
            toolbarColor: ColorsRes.fromHex(ColorsRes.primaryColor),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            hideBottomControls: true,
            lockAspectRatio: true),
        iosUiSettings: const IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
    );

    notifyListeners();
  }

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
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {

          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  color: Colors.blue,
                  playSound: true,
                  icon: '@mipmap/ic_launcher',
                ),
              ));
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
      notificationInfo = notification;
      totalNotifications++;
      notifyListeners();
    }
  }

  void onItemTipped(int index) {
    currentIndex = index;
    pageController.jumpToPage(index);
    notifyListeners();
  }

  void logout(BuildContext context) async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove('uid_account');
    Navigator.pushNamedAndRemoveUntil(
        context, '/logout', (r) => false);
  }
  // notifyListeners();
}