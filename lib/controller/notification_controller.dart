import 'package:flutter_application_1/constraints/example_data.dart';
import 'package:flutter_application_1/model/message_model.dart';
import 'package:flutter_application_1/services/notification_service.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../model/notification_model.dart';

class NotificationController extends GetxController {
  final RxList<NotificationModel> _notifications = <NotificationModel>[].obs;
  final RxList<MessageModel> _messageNotifications = <MessageModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize notification service here
    NotificationService.init();
    fetchMessageNotification();
    fetchNotification();
  }

  List<MessageModel> get messageNotification => _messageNotifications;
  List<NotificationModel> get notification => _notifications;

  void fetchNotification() {
    _notifications.value = sampleNotification
      ..sort((a, b) => b.time.compareTo(a.time));
  }

  void fetchMessageNotification() {
    _messageNotifications.value = sampleMessagesNotification
      ..sort((a, b) => b.time.compareTo(a.time));
  }

  // Method to add a new notification to the list
  void addNotification(RemoteMessage message) {
    final notification = NotificationModel(
        id: message.messageId ?? '',
        title: message.notification?.title ?? 'No Title',
        body: message.notification?.body ?? 'No Body',
        sender: message.data['sender'] ?? 'Unknown',
        time: DateTime.now().toString(),
        type: message.messageType ?? "Message");

    _notifications.add(notification);
  }

  void addMessageNotification(RemoteMessage message) {
    final messageNotification = MessageModel(
        id: message.messageId ?? '',
        title: message.notification?.title ?? 'No Title',
        body: message.notification?.body ?? 'No Body',
        sender: message.data['sender'] ?? 'Unknown',
        senderProfile: message.data['sender_profile'] ?? '',
        imageUrl: message.data['image_url'] ?? '',
        time: DateTime.now().toString());

    _messageNotifications.add(messageNotification);
  }
}
