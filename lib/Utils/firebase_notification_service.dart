import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging_flutter/Utils/local_notification_service.dart';
import 'package:firebase_messaging_flutter/View/notification_screen.dart';
import 'package:get/get.dart';

class FirebaseNotificationServices {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await firebaseMessaging.requestPermission();

    String? token = await firebaseMessaging.getToken();
    log('Token: $token');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      LocalNotificationService().showNotification(
        title: message.notification!.title,
        body: message.notification!.body,
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handleNotification(message);
    });

    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      handleNotification(initialMessage);
    }
  }

  void handleNotification(RemoteMessage? message) {
    if (message != null) {
      Get.to(() => NotificationScreen(message: message));
    }
  }
}
