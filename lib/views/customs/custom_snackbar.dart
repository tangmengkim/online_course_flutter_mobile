import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/color_constant.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void showError({required String title, required String description}) {
    Get.snackbar(title, description,
        colorText: Colors.white,
        backgroundColor: Colors.red[400],
        duration: Duration(seconds: 2),
        animationDuration: Duration(milliseconds: 400),
        snackPosition: SnackPosition.BOTTOM);
  }

  static void showSuccess(
      {required String title, required String description}) {
    Get.snackbar(title, description,
        colorText: Colors.white,
        backgroundColor: ColorConstant.primaryColor,
        duration: Duration(seconds: 2),
        animationDuration: Duration(milliseconds: 400),
        snackPosition: SnackPosition.BOTTOM);
  }
}
