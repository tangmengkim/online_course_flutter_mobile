import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/notification_controller.dart';
import 'package:flutter_application_1/notification/local_notification.dart';
import 'package:get/get.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final LocalNotification _localNotification = LocalNotification();

  static void init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await requestPermission();
    _localNotification.init();
    handleMessagingForeground();
    FirebaseMessaging.onBackgroundMessage(MessagingBackgroundHandler);
    getToken();
  }

  static Future<void> requestPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else {
      print('User denied or has not accepted permission');
    }
  }

  static Future<void> getToken() async {
    // String? token = await FirebaseMessaging.instance.getToken();
    String? token = await _messaging.getToken();
    print("FCM Token: $token");
  }

  static Future<void> MessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
  }

  static void handleMessagingForeground() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _localNotification.showLocalNotification(message);
      print(
          'Received a message while in foreground: ${message.notification?.title}');
      try {
        Get.find<NotificationController>().addNotification(message);
      } catch (err) {
        err.printError();
      }
    });
  }
}
