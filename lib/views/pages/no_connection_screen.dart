import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/color_constant.dart';
import 'package:flutter_application_1/views/customs/custom_button.dart';

class NoConnectionScreen extends StatelessWidget {
  final Function onTryAgain;
  const NoConnectionScreen({required this.onTryAgain, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Image.asset(
          "assets/icons/no_connection.png",
          width: 100,
        ),
        Text("No Network!",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        Text("Please check your internet connection an try again",
            style: TextStyle(fontSize: 12, color: ColorConstant.gray)),
        CustomButton.customElevatedButton(
            text: "Try again",
            onPress: () {
              onTryAgain();
            })
      ],
    ));
  }
}
