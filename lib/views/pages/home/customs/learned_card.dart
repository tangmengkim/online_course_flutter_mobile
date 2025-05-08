import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/color_constant.dart';

class AppSliverLearnedCard extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final String title;
  final InkWell textAction;
  final double learnedTime;
  final double courseTime;
  final int animationDuration;

  AppSliverLearnedCard(
      {required this.expandedHeight,
      required this.title,
      required this.textAction,
      required this.learnedTime,
      required this.courseTime,
      this.animationDuration = 400});

  static Widget learnedCard(
      {required String title,
      required double learnedTime,
      required double courseTime,
      int animationDuration = 400}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
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
              ],
            ),
            TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: learnedTime / courseTime),
                duration: Duration(milliseconds: animationDuration),
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
                }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double cardOpacity = (1 - (shrinkOffset * 2 / (expandedHeight) * 0.6))
        .clamp(0.0, 1.0); // Adjusts fade speed for the card

    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        // Background Color
        Container(
          height: MediaQuery.of(context).size.height,
          color: ColorConstant.primaryColor,
        ),

        // Stacked Card (Hides Faster)
        Positioned(
          bottom: -expandedHeight / 1,
          left: (MediaQuery.of(context).size.width -
                  MediaQuery.of(context).size.width * 0.88) /
              2.5,
          child: Opacity(
            opacity: cardOpacity, // Card disappears faster
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: SizedBox(
                height: expandedHeight * 1.7,
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
                          duration: Duration(milliseconds: animationDuration),
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
                                      style:
                                          TextStyle(color: ColorConstant.gray),
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
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
