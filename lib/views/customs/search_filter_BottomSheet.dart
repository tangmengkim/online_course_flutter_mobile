import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/search_course_controller.dart';
import 'package:flutter_application_1/utils/color_constant.dart';
import 'package:flutter_application_1/views/customs/custom_button.dart';
import 'package:flutter_application_1/views/pages/course/customs/custom_range_slider.dart';
import 'package:get/get.dart';

class SearchFilterBottomSheet extends StatefulWidget {
  final String tag;
  const SearchFilterBottomSheet(this.tag, {super.key});

  @override
  State<SearchFilterBottomSheet> createState() =>
      _SearchFilterBottomSheetState();
}

class _SearchFilterBottomSheetState extends State<SearchFilterBottomSheet> {
  late SearchCourseController searchCourseController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchCourseController = Get.find(tag: widget.tag);
  }

  late double maxPrice = 0, minPrice = double.infinity;

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      // borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close)),
            title: Text("Search Filter"),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          ),
          SingleChildScrollView(
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildText("Categories"),
                Obx(
                  () => Wrap(
                    spacing: 10,
                    children: searchCourseController
                        .courseController.courseCategories
                        .map((item) {
                      bool isActive = searchCourseController.selectedCategory
                          .contains(item);
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextButton(
                            onPressed: () =>
                                searchCourseController.selectCategory(item),
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                backgroundColor: isActive
                                    ? ColorConstant.primaryColor
                                    : ColorConstant.lightGray,
                                foregroundColor: isActive
                                    ? Colors.white
                                    : ColorConstant.darkGray),
                            child: Text(item)),
                      );
                    }).toList(),
                  ),
                ),
                _buildText("Price"),
                Obx(
                  () => _buildRangeSlider(
                    min: 0.0,
                    max: 500.0,
                    rangeValues: RangeValues(
                        searchCourseController.minPrice.value,
                        searchCourseController.maxPrice.value),
                    onChanged: (RangeValues newValues) => searchCourseController
                        .updatePriceRange(newValues.start, newValues.end),
                  ),
                ),
                _buildText("Duration"),
                Obx(
                  () => _buildSelectItem(
                      items: searchCourseController
                          .courseController.rangeCourseDuration,
                      labelBuilder: (p0) => p0.toString(),
                      selectedItems: searchCourseController.selectedDuration,
                      onClick: (item) =>
                          searchCourseController.selectDuration(item)),
                ),
                Row(
                  spacing: 15,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: CustomButton.customElevatedButton(
                          text: "Clear",
                          onPress: () => {
                                Navigator.pop(context),
                                searchCourseController.clearFilter()
                              },
                          backgroundColor: Colors.white,
                          foregroundColor: ColorConstant.primaryColor),
                    ),
                    Expanded(
                        flex: 7,
                        child: CustomButton.customElevatedButton(
                            text: "Apply Filtter",
                            onPress: () => {
                                  Navigator.pop(context),
                                  searchCourseController.applyFilter()
                                }))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Text _buildText(String text, {TextStyle? style}) => Text(text,
      style: style ?? TextStyle(fontSize: 18, fontWeight: FontWeight.bold));

  Widget _buildSelectItem<T>({
    required List<T> items,
    required List<T> selectedItems, // Generic selected list
    required String Function(T) labelBuilder, // Converts item to string
    required Function(T) onClick,
  }) {
    return Wrap(
      spacing: 10,
      children: items.map((item) {
        bool isActive = selectedItems.contains(item);
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: TextButton(
            onPressed: () => onClick(item),
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              backgroundColor: isActive
                  ? ColorConstant.primaryColor
                  : ColorConstant.lightGray,
              foregroundColor: isActive ? Colors.white : ColorConstant.gray,
            ),
            child:
                Text(labelBuilder(item)), // Convert item to label dynamically
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRangeSlider({
    required RangeValues rangeValues,
    required double min,
    required double max,
    required ValueChanged<RangeValues> onChanged,
  }) {
    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 1,
        activeTrackColor: ColorConstant.primaryColor,
        inactiveTrackColor: ColorConstant.gray, minThumbSeparation: 30,
        rangeThumbShape:
            CustomRangeSliderThumb(thumbRadius: 10), // Custom thumb with border
        rangeValueIndicatorShape: CustomValueIndicator(),
        showValueIndicator: ShowValueIndicator.always,
        valueIndicatorStrokeColor: Colors.blueAccent,
      ),
      child: RangeSlider(
        // divisions: 10,
        min: min,
        max: max,
        values: rangeValues,
        labels: RangeLabels(
          "\$ ${rangeValues.start.toStringAsFixed(0)}",
          "\$ ${rangeValues.end.toStringAsFixed(0)}",
        ),
        onChanged: (RangeValues newValues) => onChanged(newValues),
      ),
    );
  }
}
