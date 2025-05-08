import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/course_controller.dart';
import 'package:flutter_application_1/controller/search_course_controller.dart';
import 'package:flutter_application_1/utils/color_constant.dart';
import 'package:flutter_application_1/views/customs/custom_course_card.dart';
import 'package:flutter_application_1/views/customs/custom_search_text_field.dart';
import 'package:flutter_application_1/views/customs/custom_sliverheader.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  final String tag = "search_screen";
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SearchCourseController searchCourseController;
  late CourseController courseController;
  @override
  void initState() {
    super.initState();
    courseController = Get.put(CourseController());
    searchCourseController = Get.put(tag: widget.tag, SearchCourseController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: CustomSliverheader(
                  child: Column(
                    children: [
                      CustomSearchTextField(tag: widget.tag),
                      _buildCourseCategories(),
                    ],
                  ),
                  maxHeight: 120,
                  minHeight: 120),
            ),
            SliverList.list(addAutomaticKeepAlives: false, children: [
              Text("Result", style: TextStyle(fontWeight: FontWeight.bold))
            ]),
            CustomCourseCardList(searchCourseController)
          ],
        ),
      ),
    );
  }

  Widget _buildCourseCategories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 6,
        children: searchCourseController.courseController.courseCategories
            .map((item) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextButton(
                onPressed: () =>
                    searchCourseController.searchByCategories(item),
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    backgroundColor: ColorConstant.lightGray,
                    foregroundColor: ColorConstant.darkGray),
                child: Text(item)),
          );
        }).toList(),
      ),
    );
  }
}
