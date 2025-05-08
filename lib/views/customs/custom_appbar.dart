import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/color_constant.dart';

class CustomSliverAppbar extends StatelessWidget {
  final Widget title, action;
  const CustomSliverAppbar(
      {super.key, required this.title, required this.action});

  @override
  Widget build(BuildContext context) {
    final double _paddingScreen = 10;
    return SliverAppBar(
      pinned: true,
      expandedHeight: 50,
      backgroundColor: ColorConstant.primaryColor,
      title: Padding(
        padding: EdgeInsets.all(_paddingScreen),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [title],
            ),
          ],
        ),
      ),
      actions: [action],
    );
  }
}
