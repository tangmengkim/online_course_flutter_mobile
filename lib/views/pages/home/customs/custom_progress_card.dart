import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/course_controller.dart';
import 'package:flutter_application_1/utils/color_constant.dart';
import 'package:get/get.dart';

class CustomProgressCard extends StatelessWidget {
  final String title;
  final InkWell textAction;
  final int courseId; // Added courseId to find progress

  const CustomProgressCard({
    Key? key,
    required this.title,
    required this.textAction,
    required this.courseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CourseController courseController = Get.find<CourseController>();

    return Obx(() {
      var progressData = courseController.userProgress.firstWhereOrNull(
        (progress) => progress.courseId == courseId,
      );

      double learnedTime = progressData?.progress.toDouble() ?? 0;
      double courseTime =
          100.0; // Example total course time (fetch dynamically if needed)

      return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: SizedBox(
          height: 180,
          width: MediaQuery.of(context).size.width * 0.88,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(color: ColorConstant.gray),
                    ),
                    textAction
                  ],
                ),
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: learnedTime / courseTime),
                  duration: Duration(milliseconds: 1000),
                  builder: (context, value, _) {
                    return Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${(value * courseTime).toStringAsFixed(0)}min",
                              style: TextStyle(fontSize: 22),
                            ),
                            Text(
                              "/ ${courseTime.toStringAsFixed(0)}min",
                              style: TextStyle(color: ColorConstant.gray),
                            ),
                          ],
                        ),
                        LinearProgressIndicator(
                          value: value,
                          minHeight: 10,
                          color: Colors.deepOrangeAccent,
                          borderRadius: BorderRadius.circular(20),
                          backgroundColor: Colors.transparent,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
