import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/search_course_controller.dart';
import 'package:flutter_application_1/utils/color_constant.dart';
import 'package:flutter_application_1/views/customs/search_filter_BottomSheet.dart';
import 'package:get/get.dart';

class CustomSearchTextField extends StatefulWidget {
  final String tag;

  const CustomSearchTextField({required this.tag, super.key});

  @override
  State<CustomSearchTextField> createState() => _CustomSearchTextFieldState();
}

class _CustomSearchTextFieldState extends State<CustomSearchTextField> {
  late SearchCourseController searchCourseController;
  final TextEditingController _searchTextController = TextEditingController();
  final RxBool isSearchText = false.obs; // Reactive boolean

  @override
  void initState() {
    super.initState();
    searchCourseController = Get.find(tag: widget.tag);

    // Listen to text changes reactively
    _searchTextController.addListener(() {
      isSearchText.value = _searchTextController.text.isNotEmpty;
    });
    _searchTextController.text = searchCourseController.searchQuery.value;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        onSubmitted: (value) {
          searchCourseController.searchQuery.value = value;
          searchCourseController.applyFilter();
        },
        controller: _searchTextController,
        autocorrect: false,
        decoration: InputDecoration(
          filled: true,
          fillColor: ColorConstant.lightGray,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide.none,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide.none),
          hintText: "Find Course",
          hintStyle: TextStyle(color: ColorConstant.gray),
          prefixIcon: IconButton(
              onPressed: () {
                searchCourseController.searchQuery.value =
                    _searchTextController.text;
                searchCourseController.applyFilter();
              },
              icon: ImageIcon(
                AssetImage("assets/icons/search.png"),
                size: 20,
                color: ColorConstant.gray,
              )),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() => isSearchText.value
                  ? IconButton(
                      onPressed: () {
                        _searchTextController.clear();
                        searchCourseController.clearSearch();
                      },
                      icon: ImageIcon(
                        AssetImage("assets/icons/exit.png"),
                        size: 20,
                        color: ColorConstant.gray,
                      ),
                    )
                  : SizedBox()),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      scrollControlDisabledMaxHeightRatio: 0.7,
                      context: context,
                      builder: (context) =>
                          SearchFilterBottomSheet(widget.tag));
                },
                icon: Obx(() {
                  return ImageIcon(
                    AssetImage("assets/icons/control_panel.png"),
                    size: 26,
                    color: searchCourseController.isFiltering.value
                        ? ColorConstant.primaryColor
                        : ColorConstant.gray,
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
