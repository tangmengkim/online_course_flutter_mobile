import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/course_detail_controller.dart';
import 'package:flutter_application_1/model/course_model.dart';
import 'package:flutter_application_1/model/lesson_model.dart';
import 'package:flutter_application_1/utils/color_constant.dart';
import 'package:flutter_application_1/utils/format_time_stamp.dart';
import 'package:flutter_application_1/views/customs/custom_button.dart';
import 'package:flutter_application_1/views/pages/course/course_detail_appbar.dart';
import 'package:get/get.dart';

class CourseDetailScreen extends StatefulWidget {
  final Course course;
  const CourseDetailScreen(this.course, {super.key});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  late CourseDetailController controller;

  @override
  void initState() {
    controller = Get.put(CourseDetailController(widget.course));
    print(controller.initialized);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CourseDetailAppbar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                spacing: 6,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.course.title,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "\$${widget.course.price.toStringAsFixed(2)}",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorConstant.primaryColor),
                      ),
                    ],
                  ),
                  Text(
                    "${widget.course.hours}h • ${widget.course.totalLessons} Lessons",
                    style: TextStyle(color: ColorConstant.darkGray),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "About this course",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.course.description,
                    style: TextStyle(color: ColorConstant.darkGray),
                  ),
                  Obx(() {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: IconButton(
                          style: ButtonStyle(
                              splashFactory: NoSplash.splashFactory),
                          onPressed: controller.toggleVisible,
                          icon: controller.isShowLesson.isFalse
                              ? Icon(Icons.keyboard_arrow_up_rounded)
                              : Icon(Icons.keyboard_arrow_down_rounded)),
                    );
                  }),
                  Obx(() {
                    if (controller
                                .videoController.currentlyPlayingLesson.value !=
                            null &&
                        controller.videoController.chewieControllers
                            .containsKey(controller.videoController
                                .currentlyPlayingLesson.value!.id)) {
                      return AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Chewie(
                          controller:
                              controller.videoController.chewieControllers[
                                  controller.videoController
                                      .currentlyPlayingLesson.value!.id]!,
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  }),
                ],
              ),
            ),
          ),
          Obx(() {
            if (controller.isLoadingLesson) {
              return SliverFillRemaining(
                hasScrollBody: false, // Disable scroll when loading
                child: Center(child: CircularProgressIndicator()),
              );
            }
            return controller.isShowLesson.isTrue
                ? SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return _buildLessonCard(
                            controller.getLessonList[index]);
                      },
                      childCount: controller.getLessonList.length,
                    ),
                  )
                : const SliverToBoxAdapter(child: SizedBox()); // Empty state
          }),
        ],
      ),
      bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Shadow color
                spreadRadius: 1, // The spread radius of the shadow
                blurRadius: 8, // The blur radius of the shadow
                offset: Offset(
                    0, -2), // Offset of the shadow (negative to move it up)
              ),
            ],
          ),
          child: _buildBuyLayout()),
    );
  }

  Widget _buildLessonCard(LessonModel lesson) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              spacing: 20,
              children: [
                Text(
                  lesson.lessonNumber.toString().padLeft(2, '0'),
                  style: TextStyle(
                      color: ColorConstant.gray,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        lesson.title,
                        style: TextStyle(fontSize: 16),
                      ),
                      Obx(
                        () => Row(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              FormatTimeStamp.formatSecondToMinute(
                                  lesson.duration),
                              style: TextStyle(
                                  color: controller
                                              .videoController
                                              .currentlyPlayingLesson
                                              .value
                                              ?.id ==
                                          lesson.id
                                      ? ColorConstant.orange
                                      : ColorConstant.darkGray,
                                  fontWeight: FontWeight.bold),
                            ),
                            // Icon(
                            //   Icons.check_circle_rounded,
                            //   color: ColorConstant.orange,
                            //   size: 18,
                            // )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          _buildPlayOrPauseButton(lesson)
        ],
      ),
    );
  }

  Widget _buildPlayOrPauseButton(LessonModel lesson) {
    return Obx(() {
      return AbsorbPointer(
        absorbing: false,
        child: GestureDetector(
            onTap: () => controller.togglePlayPause(lesson),
            child: Opacity(
              opacity: lesson.isLocked ? 0.5 : 1,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                      radius: 26,
                      backgroundColor: ColorConstant.primaryColor,
                      child: lesson.isLocked
                          ? Icon(Icons.lock)
                          : controller.videoController.currentlyPlayingLesson
                                      .value !=
                                  lesson
                              ? controller.videoController.isloading.value &&
                                      controller.videoController
                                              .currentlyStartPlayLesson.value ==
                                          lesson
                                  ? CircularProgressIndicator.adaptive(
                                      backgroundColor: Colors.white,
                                    )
                                  : Icon(Icons.play_arrow_rounded)
                              : Icon(Icons.pause)),
                  controller.videoController.currentlyPlayingLesson.value ==
                              lesson &&
                          controller.videoController.isPlaying.value
                      ? SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            value:
                                controller.videoController.getPlayedDuration(),
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation(ColorConstant.orange),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            )),
      );
    });
  }

  Widget _buildBuyLayout() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 18, bottom: 34, right: 20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ElevatedButton.icon(
                  style: ButtonStyle(
                    elevation: const WidgetStatePropertyAll(0),
                    backgroundColor:
                        WidgetStatePropertyAll(ColorConstant.lightPink),
                    splashFactory: NoSplash.splashFactory,
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(14)),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  label: Container(
                    padding: EdgeInsets.all(14),
                    child: Icon(
                      Icons.star_border,
                      color: ColorConstant.orange,
                      size: 26,
                    ),
                  )),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: CustomButton.customElevatedButton(
                    text: "Buy Now", onPress: () {}))
          ],
        ),
      ),
    );
  }
}
