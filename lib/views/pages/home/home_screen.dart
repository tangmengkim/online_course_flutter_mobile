import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constraints/constraint.dart';
import 'package:flutter_application_1/controller/auth_controller.dart';
import 'package:flutter_application_1/controller/bottom_nav_controller.dart';
import 'package:flutter_application_1/utils/color_constant.dart';
import 'package:flutter_application_1/views/pages/home/my_course_screen.dart';
import 'package:get/get.dart';

import '../../../constraints/example_data.dart';
import 'customs/learned_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthController controller = Get.find<AuthController>();
  final BottomNavController navController = Get.find<BottomNavController>();
  final List adsSuggestion = suggestion;
  final double _paddingScreen = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
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
                  children: [
                    // Title (Always Visible)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Hi, Kristin",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Let’s start learning",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    // Profile Icon (Always Visible)
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
              ],
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(background: Container()),
        ),
        SliverPersistentHeader(
          floating: false,
          pinned: false,
          delegate: AppSliverLearnedCard(
              expandedHeight: 60,
              title: "Learned today",
              textAction: InkWell(
                onTap: () {
                  Get.to(() => MyCourseScreen());
                },
                child: Text(
                  "My courses",
                  style: TextStyle(color: ColorConstant.primaryColor),
                ),
              ),
              learnedTime: 46,
              courseTime: 60),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          fillOverscroll: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 70),
              CarouselSlider.builder(
                options: CarouselOptions(
                    height: 200,
                    aspectRatio: 16 / 9,
                    enableInfiniteScroll: false,
                    disableCenter: true,
                    scrollPhysics: BouncingScrollPhysics(),
                    enlargeCenterPage: false,
                    viewportFraction: 0.88,
                    initialPage: 0),
                itemCount: adsSuggestion.length,
                itemBuilder: (context, index, realIndex) {
                  return _suggestionCard(adsSuggestion[index]);
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: _paddingScreen * 2.5),
                child: _learningPlan(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: _paddingScreen * 1.2, vertical: _paddingScreen),
                child: Image.asset(
                  "assets/icons/Meetup.png",
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }

  Widget _suggestionCard(Suggestion suggestion) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstant.lightBlue,
          borderRadius: BorderRadius.circular(20),
        ),
        // width: MediaQuery.of(context).size.width * 0.6,
        // height: 200,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                suggestion.title ?? "",
                style: TextStyle(fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstant.orange,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          padding: EdgeInsets.symmetric(horizontal: 10)),
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  suggestion.icon != null
                      ? FittedBox(
                          child: Image.asset(
                            suggestion.icon ?? "",
                            height: 150,
                          ),
                        )
                      : SizedBox()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _learningPlan() {
    final List learningLevel = learnLevel;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: _paddingScreen),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Learning Plan",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 0),
            elevation: 6,
            child: Padding(
              padding: EdgeInsets.only(
                  left: _paddingScreen,
                  right: _paddingScreen,
                  top: 10,
                  bottom: 40),
              child: Column(
                children: List.generate(learningLevel.length, (index) {
                  return _learningLevel(learningLevel[index]);
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _learningLevel(LearningLevel lLevel) {
    final int duration = 1000;

    return Padding(
      padding: EdgeInsets.all(_paddingScreen),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: lLevel.value / lLevel.maxValue),
        duration: Duration(milliseconds: duration),
        builder: (context, value, child) {
          return SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    value: value,
                    backgroundColor: ColorConstant.lightGray,
                    color: ColorConstant.gray,
                    strokeWidth: 5,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  lLevel.title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${(value * lLevel.maxValue).toStringAsFixed(0)}min",
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      "/ ${lLevel.maxValue.toStringAsFixed(0)}min",
                      style: TextStyle(color: ColorConstant.gray, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
