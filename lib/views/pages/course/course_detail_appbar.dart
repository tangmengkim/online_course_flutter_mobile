import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/course_detail_controller.dart';
import 'package:flutter_application_1/utils/color_constant.dart';
import 'package:get/get.dart';

class CourseDetailAppbar extends StatelessWidget {
  final CourseDetailController controller = Get.find<CourseDetailController>();
  CourseDetailAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      print("playing:");
      print(controller.videoController.currentlyStartPlayLesson.value == null);
      print(controller.videoController.currentlyPlayingLesson.value == null);
      return TweenAnimationBuilder<double>(
        tween: Tween(
          begin: controller.isShowLesson.value ? 500 : 275,
          end: controller.isShowLesson.value ? 275 : 500,
        ),
        duration: Duration(milliseconds: 120),
        builder: (context, value, child) {
          return SliverAppBar(
            expandedHeight: value,
            elevation: 0,
            pinned: true,
            collapsedHeight: 90,
            stretch: true,
            automaticallyImplyLeading: false,
            centerTitle: false,
            title: controller.videoController.currentlyStartPlayLesson.value ==
                    null
                ? IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_new_rounded),
                  )
                : null,
            backgroundColor:
                controller.videoController.currentlyStartPlayLesson.value ==
                        null
                    ? ColorConstant.lightPink
                    : ColorConstant.darkBlue,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: controller
                          .videoController.currentlyPlayingLesson.value ==
                      null
                  ? Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      "assets/icons/Illustration2.png",
                                      height: 160,
                                    ),
                                    Image.asset(
                                      "assets/icons/Illustration.png",
                                      height: 220,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 6, bottom: 6, left: 12, right: 20),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.horizontal(
                                            right: Radius.circular(90))),
                                    child: Text("BESTSELLER"),
                                  ),
                                  Text(
                                    controller.course.title,
                                    style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox()
                            ],
                          ),
                        )
                      ],
                    )
                  : Container(
                      // color:
                      //     controller.videoController.currentlyStartPlayLesson.value ==
                      //             null
                      //         ? ColorConstant.lightPink
                      //         : ColorConstant.darkBlue,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Obx(() {
                              final currentlyPlayingLesson = controller
                                  .videoController.currentlyPlayingLesson.value;
                              if (currentlyPlayingLesson != null &&
                                  controller.videoController.chewieControllers
                                      .containsKey(currentlyPlayingLesson.id
                                          .toString())) {
                                return AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: Chewie(
                                    controller: controller
                                            .videoController.chewieControllers[
                                        currentlyPlayingLesson.id.toString()]!,
                                  ),
                                );
                              } else {
                                return SizedBox
                                    .shrink(); // Hide video when no lesson is selected
                              }
                            }),
                          ),
                        ],
                      ),
                    ),
              stretchModes: [
                StretchMode.blurBackground,
                StretchMode.zoomBackground
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: Container(
                height: 32,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
