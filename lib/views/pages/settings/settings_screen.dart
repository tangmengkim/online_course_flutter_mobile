import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/auth_controller.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/utils/color_constant.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AuthController authController = Get.find<AuthController>();
  final User user = User(id: 01, name: "Dara", email: "email@gmail.com");
  final List<Setting> settings = [
    Setting(title: "Favourite", onTap: () {}),
    Setting(title: "Edit Account", onTap: () {}),
    Setting(title: "Settings and Privacy", onTap: () {}),
    Setting(title: "Help", onTap: () {}),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            "Account",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          ),
          actions: [
            IconButton(
                onPressed: () => showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: Text("Sign Out of App?"),
                        content: Text(
                            "Are you sure that you would like to sign out?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Cancel",
                                style: TextStyle(
                                    color: ColorConstant.primaryColor)),
                          ),
                          TextButton(
                            onPressed: () => authController.signOut(),
                            child: Text(
                              "Sign Out",
                              style:
                                  TextStyle(color: ColorConstant.primaryColor),
                            ),
                          )
                        ],
                      ),
                    ),
                icon: Icon(
                  Icons.logout_rounded,
                ))
          ],
        ),
        body: Column(
          children: [
            SizedBox(height: 10),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?q=80&w=2770&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                    imageBuilder: (context, imageProvider) => Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle, // Example: Circular Avatar
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 10,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(4),
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorConstant.primaryColor,
                                  border: Border.all(
                                      color: Colors.white, width: 1.5)),
                              child: ImageIcon(
                                AssetImage(
                                  "assets/icons/camera.png",
                                ),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    placeholder: (context, url) => Center(
                        child:
                            CircularProgressIndicator()), // Placeholder while loading
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error), // Error case
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                  itemCount: settings.length,
                  itemBuilder: (context, index) => ListTile(
                        onTap: () => settings[index].onTap,
                        title: Text(settings[index].title),
                        trailing: ImageIcon(
                          AssetImage("assets/icons/right.png"),
                          size: 14,
                          color: ColorConstant.darkGray,
                        ),
                      )),
            )
          ],
        ),
      ),
    );
  }
}

class Setting {
  final String title;
  final Function onTap;

  Setting({required this.title, required this.onTap});
}
