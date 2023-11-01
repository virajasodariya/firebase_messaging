import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void requestNotificationPermissions() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    /// for android we use authorized access
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log("user granted authorization permission");
    }

    /// for ios we use provisional access
    else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      log("user granted provisional permission");
    }

    /// if user denied permission
    else {
      log("user denied permission");
    }
  }

  Future<String?> getDeviceToken() async {
    String? token = await messaging.getToken();
    log("----------deviceToken---------- $token");
    return token;
  }
}

class NotificationServiceLocal {
  FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    DarwinInitializationSettings iOSSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? playLoad) async {},
    );

    InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iOSSettings);

    await localNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? playLoad}) async {
    localNotificationsPlugin.show(id, title, body, await notificationDetails());
  }
}
