import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AppNotificationHandler {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future initializeNotification() async {
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  /// To get FCM token of the device:
  static Future getFcmToken() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    try {
      String? token = await firebaseMessaging.getToken();
      log("=========fcm-token===$token");
      return token;
    } catch (e) {
      return null;
    }
  }

  static void showMsgHandler() async {
    debugPrint('call when app in fore ground');
    try {
      FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
        RemoteNotification? notification = message!.notification;

        try {
          debugPrint('Notification Title  ${notification!.title}');
          debugPrint('Notification Body   ${notification.body}');
          debugPrint("JSON==>>${message.data}");
        } catch (e) {
          // TODO
        }

        try {
          if (message.data['id'] == "status_update") {
          } else if (message.data['id'] == "chat_msg") {}
        } catch (e) {
          // TODO
        }

        try {} catch (e) {
          // TODO
        }

        if (Platform.isAndroid) {
          showMsgNormal(notification!, message);
        }
      });
    } on FirebaseException catch (e) {
      debugPrint('notification error ${e.message}');
      return null;
    }
    return null;
  }

  /// handle notification when app in fore ground:

  static void getInitialMsg() {
    debugPrint('handle notification when app in fore ground..///close app');
    FirebaseMessaging.instance.getInitialMessage().then(
      (RemoteMessage? message) {
        debugPrint('------RemoteMessage message------$message');
      },
    );
  }

  /// Highest Importance Android Notification Channel:
  static AndroidNotificationChannel
      highestImportanceAndroidNotificationChannel =
      const AndroidNotificationChannel(
          'high_importance_channel', // id
          'High Importance Notifications', // titleon
          playSound: true,
          enableLights: true,
          enableVibration: true,
          importance: Importance.high,
          showBadge: true);

  /// Standard Android Notification Channel:
  static AndroidNotificationChannel standardAndroidNotificationChannel =
      const AndroidNotificationChannel(
          'normal_importance_channel', // id
          'Normal Importance Notifications', // title
          playSound: true,
          enableLights: true,
          enableVibration: true,
          importance: Importance.low);

  static void showMsgNormal(
      RemoteNotification notification, RemoteMessage msg) {
    if (kDebugMode) {
      print('MESSAGE NORMAL SHOW');
    }

    try {
      //String screen = jsonEncode(msg.data);
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            standardAndroidNotificationChannel.id,
            standardAndroidNotificationChannel.name, // id
            importance: Importance.low,
            icon: '@mipmap/ic_launcher',
          ),
        ),
      );
    } catch (e) {
      debugPrint('notification 3 $e');
    }
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    try {
      debugPrint('background notification handler..');
      await Firebase.initializeApp();
      debugPrint('Handling a background message ${message.messageId}');
      RemoteNotification? notification = message.notification;
    } on FirebaseException catch (e) {
      debugPrint('notification 1 ${e.message}');
    }
  }

  ///call when click on notification back
  static void onMsgOpen() {
    debugPrint('call when click on notification back');
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        debugPrint('listen->${message.data}');
      },
    );
  }
}
