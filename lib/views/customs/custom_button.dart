import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/color_constant.dart';

class CustomButton {
  static ElevatedButton customElevatedButton({
    required String text,
    required VoidCallback onPress,
    Color backgroundColor = ColorConstant.primaryColor,
    Color foregroundColor = Colors.white,
  }) {
    return ElevatedButton(
      style: customButtonStyle(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
      onPressed: onPress,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          text,
          style: TextStyle(color: foregroundColor, fontSize: 16),
        ),
      ),
    );
  }

  static ButtonStyle customButtonStyle({
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    return ButtonStyle(
      elevation: const WidgetStatePropertyAll(0),
      backgroundColor: WidgetStatePropertyAll(backgroundColor),
      splashFactory: NoSplash.splashFactory,
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(14)),
          side: BorderSide(color: foregroundColor),
        ),
      ),
    );
  }
}
