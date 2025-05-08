import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/color_constant.dart';

final ThemeData lightTheme = ThemeData(
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      unselectedItemColor: ColorConstant.lightGray,
      unselectedIconTheme: IconThemeData(color: ColorConstant.lightGray)),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorConstant.lightGray,
      foregroundColor: ColorConstant.primaryColor),
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  cardTheme: CardTheme(
    color: Colors.white,
    shadowColor: ColorConstant.shadow,
  ),
  colorScheme: ColorScheme.light(
    primary: Colors.blue,
    secondary: Colors.orange,
  ),
);

final ThemeData darkTheme = ThemeData(
  appBarTheme: AppBarTheme(backgroundColor: ColorConstant.darkBlue),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: ColorConstant.gray,
      backgroundColor: Color.fromARGB(255, 35, 35, 60)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorConstant.darkBlue,
      unselectedIconTheme: IconThemeData(color: ColorConstant.gray)),
  brightness: Brightness.dark,
  primaryColor: Colors.blueGrey,
  cardTheme: CardTheme(
    color: ColorConstant.blueGray,
    shadowColor: ColorConstant.lightShadow,
  ),
  scaffoldBackgroundColor: ColorConstant.darkBlue,
  colorScheme: ColorScheme.dark(
    primary: Colors.blueGrey,
    secondary: Colors.deepOrange,
  ),
);
