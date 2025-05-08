import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth_binding.dart';
import 'package:flutter_application_1/controller/notification_controller.dart';
import 'package:flutter_application_1/utils/theme.dart';
import 'package:get/get.dart';
import 'routes/app_route.dart';

void main() async {
  Get.put(NotificationController());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: lightTheme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        initialBinding: AuthBinding(),
        initialRoute: '/home',
        getPages: AppRoute.routes);
  }
}
