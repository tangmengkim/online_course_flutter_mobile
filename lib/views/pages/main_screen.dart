import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/bottom_nav_controller.dart';
import 'package:flutter_application_1/utils/color_constant.dart';
import 'package:flutter_application_1/views/pages/course/course_screen.dart';
import 'package:flutter_application_1/views/pages/notification/notification_screen.dart';
import 'package:flutter_application_1/views/pages/settings/settings_screen.dart';
import 'package:get/get.dart';

import 'home/home_screen.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  final _bottomNavController = Get.put(BottomNavController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        switch (_bottomNavController.currentIndex.value) {
          case 0:
            return HomeScreen();
          case 1:
            return CourseScreen();
          case 2:
            return Container();
          case 3:
            return NotificationScreen();
          case 4:
            return SettingsScreen();
          default:
            return HomeScreen();
        }
      }),
      bottomNavigationBar: Obx(() {
        return Theme(
          data: ThemeData(
            splashFactory: NoSplash.splashFactory, // Disables ripple
            highlightColor: Colors.transparent, // Prevents highlight effect
          ),
          child: BottomAppBar(
            height: 60,
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            padding: EdgeInsets.all(0),
            child: _bottomNavBarOld(),
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 24,
            left: MediaQuery.of(context).size.width / 2 - 28,
            child: FloatingActionButton(
              onPressed: () {
                _bottomNavController.changeIndex(2);
              },
              splashColor: Colors.transparent,
              elevation: 0,
              highlightElevation: 0,
              autofocus: false,
              shape: CircleBorder(
                  side: BorderSide(
                      color: Theme.of(context)
                              .bottomNavigationBarTheme
                              .backgroundColor ??
                          Theme.of(context).primaryColor,
                      width: 5)),
              child: ImageIcon(
                AssetImage("assets/icons/search.png"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomNavBarOld() {
    return Stack(
      children: [
        BottomNavigationBar(
          elevation: 0,
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          backgroundColor:
              Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          unselectedIconTheme:
              Theme.of(context).bottomNavigationBarTheme.unselectedIconTheme,
          type: BottomNavigationBarType.fixed,
          currentIndex: _bottomNavController.currentIndex.value,
          onTap: (index) => _bottomNavController.changeIndex(index),
          unselectedItemColor: ColorConstant.gray,
          selectedItemColor: ColorConstant.primaryColor,
          unselectedFontSize: 10,
          selectedFontSize: 10,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/icons/home.png")),
                label: "Home"),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/icons/book.png")),
                label: "Course"),
            BottomNavigationBarItem(
                activeIcon: null, icon: Icon(null), label: "Search"),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/icons/message.png")),
                label: "Message"),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/icons/person.png")),
                label: "Account"),
          ],
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          left: MediaQuery.of(context).size.width /
                  5 *
                  _bottomNavController.currentIndex.value +
              MediaQuery.of(context).size.width / 10 -
              15.5,
          top: 0,
          child: Container(
            width: 30,
            height: 2,
            decoration: BoxDecoration(
              color: ColorConstant.primaryColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ],
    );
  }
}
