import 'package:firebase_messaging_flutter/Utils/local_notification_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Firebase Notification")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            LocalNotificationService().showNotification(
              title: "Flutter Local Notification",
              body: "its working",
            );
          },
          child: const Text("Show Notification"),
        ),
      ),
    );
  }
}
