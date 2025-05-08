import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final AuthController authController = Get.find<AuthController>();

    // Ensure the authentication status is checked before proceeding
    authController.checkAuthStatus().then((_) {
      print(
          "Middleware Check: isAuthenticated = ${authController.isAuthenticated.value}");
      if (!authController.hasAuthenticated()) {
        Get.offAllNamed('/signin');
      }
      return null;
    });

    return null;
  }
}
