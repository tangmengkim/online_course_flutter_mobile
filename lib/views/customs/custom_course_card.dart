import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/search_course_controller.dart';
import 'package:flutter_application_1/model/course_model.dart';
import 'package:flutter_application_1/utils/color_constant.dart';
import 'package:flutter_application_1/views/pages/course/course_detail_screen.dart';
import 'package:flutter_application_1/views/pages/no_connection_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class CustomCourseCardList extends StatelessWidget {
  final SearchCourseController searchCourseController;
  const CustomCourseCardList(this.searchCourseController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Handling loading state
      if (searchCourseController.courseController.isLoading.value) {
        return SliverFillRemaining(
          hasScrollBody: false, // Disable scroll when loading
          child: Center(child: CircularProgressIndicator()),
        );
      }

      // Handle no data state
      if (searchCourseController.filteredCourses.isEmpty) {
        return SliverFillRemaining(
          hasScrollBody: false,
          child: searchCourseController.isNoConnection.value
              ? NoConnectionScreen(
                  onTryAgain: searchCourseController.refreshData,
                )
              : Center(
                  child: Text(
                    "No data recorded",
                    style: TextStyle(color: ColorConstant.darkGray),
                  ),
                ),
        );
      }

      // Return SliverList with course data
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: CustomCourseCard(
                  searchCourseController.filteredCourses[index]),
            );
          },
          childCount: searchCourseController.filteredCourses.length,
        ),
      );
    });
  }
}

class CustomCourseCard extends StatelessWidget {
  final Course course;
  const CustomCourseCard(this.course, {super.key});

  void viewCourseDetail(Course course) {
    Get.to(() => CourseDetailScreen(course));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => viewCourseDetail(course),
      child: Card(
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //     color: ColorConstant.lightGray,
              //   ),
              //   width: 80,
              //   height: 80,
              // ),
              CachedNetworkImage(
                imageUrl: course.profileImageUrl,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorConstant.lightGray,
                  ),
                  width: 80,
                  height: 80,
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: ColorConstant.gray,
                        ),
                        Text(
                          "${course.author}",
                          style: TextStyle(color: ColorConstant.gray),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "\$${course.price.toStringAsFixed(0)}",
                          style: TextStyle(
                              color: ColorConstant.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.transparent
                                  : ColorConstant
                                      .lightPink, // Use your predefined color,
                              borderRadius: BorderRadius.circular(20)),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "${course.hours.toString()} ${course.hours > 1 ? "hours" : "hour"}",
                            style: TextStyle(
                                fontSize: 10, color: ColorConstant.orange),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
