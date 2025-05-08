import 'package:flutter/material.dart';

class ColorConstant {
  // Define standard colors
  static const Color primaryColor = Color(0xFF3D5CFF); // Blue
  static const Color secondaryColor = Color(0xFF00C853); // Green
  static const Color accentColor = Color(0xFF00B8D4); // Cyan

  // Define custom color shades
  static const Color lightGray = Color(0xFFF4F3FD);
  static const Color gray = Color(0xFFB8B8D2);
  static const Color darkGray = Color(0xFF707070);
  static const Color transparentGray = Color(0x391F1F39);

  static const Color shadow = Color(0x37B8B8D2);
  static const Color lightShadow = Color(0x8CB8B8D2);

  static const Color blueGray = Color(0xFF2F2F42);

  static const Color darkBlue = Color(0xFF1F1F39);
  static const Color lightBlue = Color(0xFFCEECFE);
  static const Color orange = Color(0xFFFF6905);
  static const Color lightPink = Color(0xFFFFEBF0);

  // You can even define a MaterialColor for custom shades
  static const MaterialColor customBlue = MaterialColor(
    0xFF42A5F5,
    <int, Color>{
      50: Color(0xFFE1F5FE),
      100: Color(0xFFB3E5FC),
      200: Color(0xFF81D4FA),
      300: Color(0xFF4FC3F7),
      400: Color(0xFF29B6F6),
      500: Color(0xFF42A5F5),
      600: Color(0xFF1E88E5),
      700: Color(0xFF1976D2),
      800: Color(0xFF1565C0),
      900: Color(0xFF0D47A1),
    },
  );
}
