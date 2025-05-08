import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/notification_controller.dart';
import 'package:flutter_application_1/utils/color_constant.dart';
import 'package:flutter_application_1/views/pages/notification/customs/custom_message_card.dart';
import 'package:flutter_application_1/views/pages/notification/customs/custom_notification_card.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  final notificationController = Get.find<NotificationController>();
  final List _notificationTabBar = ["message", "notification"];
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text(
              "Notification",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
          ),
          body: Column(
            children: [
              TabBar(
                labelColor: ColorConstant.primaryColor,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                        width: 2.0, color: ColorConstant.primaryColor),
                    insets: EdgeInsets.symmetric(horizontal: 75.0)),
                controller: _tabController,
                dividerColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
                tabs: [
                  ..._notificationTabBar.map((tab) => Tab(
                        child: Text(
                          tab,
                          style: TextStyle(fontSize: 16),
                        ),
                      ))
                ],
              ),
              Expanded(
                child: TabBarView(controller: _tabController, children: [
                  Obx(
                    () => ListView.builder(
                      itemCount:
                          notificationController.messageNotification.length,
                      itemBuilder: (context, index) => CustomMessageCard(
                          notificationController.messageNotification[index]),
                    ),
                  ),
                  Obx(
                    () => ListView.builder(
                      itemCount: notificationController.notification.length,
                      itemBuilder: (context, index) => CustomNotificationCard(
                          notificationController.notification[index]),
                    ),
                  )
                ]),
              )
            ],
          )),
    );
  }
}
