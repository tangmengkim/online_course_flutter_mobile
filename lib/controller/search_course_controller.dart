import 'package:flutter_application_1/controller/course_controller.dart';
import 'package:flutter_application_1/model/course_model.dart';
import 'package:get/get.dart';

class SearchCourseController extends GetxController {
  var searchQuery = ''.obs;
  var minPrice = 0.0.obs;
  var maxPrice = 500.0.obs;
  var selectedCategory = <String>[].obs;
  var selectedDuration = <RangeCourseDuration>[].obs;

  var filteredCourses = <Course>[].obs;
  final CourseController courseController = Get.find<CourseController>();

  RxBool get isFiltering => (minPrice.value != 0.0 ||
          maxPrice.value != 500.0 ||
          selectedCategory.isNotEmpty ||
          selectedDuration.isNotEmpty)
      .obs;
  RxBool get isNoConnection => (courseController.isNoConnection.value).obs;

  @override
  void onInit() {
    super.onInit();
    filteredCourses.assignAll(courseController.courses);
    ever(courseController.courses, (_) => applyFilter());
  }

  void refreshData() {
    print("refresh data.");
    courseController.refreshData();
  }

  void updatePriceRange(double min, double max) {
    minPrice.value = min;
    maxPrice.value = max;
  }

  void selectCategory(String category) {
    selectedCategory.contains(category)
        ? selectedCategory.remove(category)
        : selectedCategory.add(category);
  }

  void selectDuration(RangeCourseDuration duration) {
    selectedDuration.contains(duration)
        ? selectedDuration.remove(duration)
        : selectedDuration.add(duration);
  }

  void applyFilter() {
    filteredCourses.value = courseController.courses.where((course) {
      bool matchesTitle =
          course.title.toLowerCase().contains(searchQuery.value.toLowerCase());
      bool matchesPrice =
          course.price >= minPrice.value && course.price <= maxPrice.value;
      bool matchesDuration = selectedDuration.isEmpty ||
          selectedDuration.any((duration) =>
              course.hours.toDouble() >= duration.start &&
              course.hours.toDouble() <= duration.end);
      bool matchesCategory = selectedCategory.isEmpty ||
          selectedCategory.contains(course.category);

      return matchesTitle && matchesPrice && matchesCategory && matchesDuration;
    }).toList();
  }

  void searchByCategories(String categoryTitle) {
    filteredCourses.value = courseController.courses.where((course) {
      return course.category
          .toLowerCase()
          .contains(categoryTitle.toLowerCase());
    }).toList();
  }

  void clearSearch() {
    searchQuery.value = '';
    applyFilter();
  }

  void clearFilter() {
    selectedCategory.clear();
    selectedDuration.clear();
    minPrice.value = 0.0;
    maxPrice.value = 500.0;
    applyFilter();
  }
}

class RangeCourseDuration {
  double start, end;
  RangeCourseDuration(this.start, this.end);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RangeCourseDuration &&
          other.start == start &&
          other.end == end);

  @override
  int get hashCode => start.hashCode ^ end.hashCode;

  @override
  String toString() => '${start.toInt()}-${end.toInt()} Hours';
}
