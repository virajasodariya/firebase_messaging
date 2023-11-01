import 'package:firebase_messaging_flutter/Utils/notification_services.dart';
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
            NotificationServiceLocal().showNotification(
              title: "title",
              body: "its working",
            );
          },
          child: const Text("Show Notification"),
        ),
      ),
    );
  }
}
