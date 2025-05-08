import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/bottom_nav_controller.dart';
import 'package:flutter_application_1/controller/course_controller.dart';
import 'package:flutter_application_1/controller/search_course_controller.dart';
import 'package:flutter_application_1/utils/color_constant.dart';
import 'package:flutter_application_1/views/customs/custom_course_card.dart';
import 'package:flutter_application_1/views/customs/custom_search_text_field.dart';
import 'package:flutter_application_1/views/customs/custom_sliverheader.dart';
import 'package:flutter_application_1/views/pages/no_connection_screen.dart';
import 'package:get/get.dart';

class CourseScreen extends StatefulWidget {
  final String tag = "course_screen";
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen>
    with SingleTickerProviderStateMixin {
  late CourseController courseController;
  late SearchCourseController searchController;
  late TabController _tabController;
  late BottomNavController navController = Get.find<BottomNavController>();

  final double _paddingScreen = 18;
  final _tabList = ["All", "Popular", "New"];

  @override
  void initState() {
    super.initState();
    courseController = Get.put(CourseController());
    searchController = Get.put(SearchCourseController(), tag: widget.tag);
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          centerTitle: false,
          expandedHeight: 50,
          pinned: true,
          title: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Course",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () => navController.changeIndex(4),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 25,
                    child: Image.asset("assets/icons/Avatar.png"),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPersistentHeader(
          // floating: true,

          pinned: false,
          delegate: CustomSliverheader(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: _paddingScreen),
                child: CustomSearchTextField(tag: widget.tag),
              ),
              maxHeight: 60,
              minHeight: 60),
        ),
        SliverPersistentHeader(
            pinned: true,
            delegate: CustomSliverheader(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: _paddingScreen),
                  child: _buildAds(),
                ),
                maxHeight: 120,
                minHeight: 120)),
        SliverPersistentHeader(
          pinned: true,
          delegate: CustomSliverheader(
              child: Padding(
                padding: EdgeInsets.only(
                    top: _paddingScreen,
                    left: _paddingScreen,
                    right: _paddingScreen),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Choice your course",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    DefaultTabController(
                        length: _tabList.length,
                        child: ButtonsTabBar(
                            backgroundColor: ColorConstant.primaryColor,
                            unselectedBackgroundColor: Colors.transparent,
                            unselectedLabelStyle:
                                TextStyle(color: ColorConstant.darkGray),
                            width: 80,
                            contentCenter: true,
                            radius: 20,
                            buttonMargin: EdgeInsets.fromLTRB(0, 10, 20, 10),
                            controller: _tabController,
                            tabs: [
                              ..._tabList.map((tabTitle) => Tab(
                                    text: tabTitle,
                                  )),
                            ]))
                  ],
                ),
              ),
              maxHeight: 90,
              minHeight: 90),
        ),
        _buildCourseList()
      ],
    ));
  }

  Widget _buildAds() {
    return FittedBox(
      child: Row(
        children: [
          Image.asset("assets/icons/ads1.png"),
          SizedBox(
            width: 50,
          ),
          Image.asset("assets/icons/ads2.png"),
        ],
      ),
    );
  }

  Widget _buildCourseList() {
    return Obx(() {
      // Handling loading state
      if (courseController.isLoading.value) {
        return SliverFillRemaining(
          hasScrollBody: false, // Disable scroll when loading
          child: Center(child: CircularProgressIndicator()),
        );
      }

      // Handle no data state
      if (searchController.filteredCourses.isEmpty) {
        return SliverFillRemaining(
          hasScrollBody: false,
          child: searchController.isNoConnection.value
              ? NoConnectionScreen(
                  onTryAgain: searchController.refreshData,
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
              padding: EdgeInsets.symmetric(horizontal: _paddingScreen),
              child: CustomCourseCard(searchController.filteredCourses[index]),
            );
          },
          childCount: searchController.filteredCourses.length,
        ),
      );
    });
  }
}
