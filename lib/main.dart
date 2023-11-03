import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging_flutter/Utils/firebase_notification_service.dart';
import 'package:firebase_messaging_flutter/Utils/local_notification_service.dart';
import 'package:firebase_messaging_flutter/View/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await LocalNotificationService().initNotification();
  await FirebaseNotificationServices().initNotifications();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Notifications',
      home: HomeScreen(),
    );
  }
}
