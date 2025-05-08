import 'package:flutter_application_1/constraints/example_data.dart';
import 'package:flutter_application_1/controller/search_course_controller.dart';
import 'package:flutter_application_1/model/course_model.dart';
import 'package:flutter_application_1/model/user_course_progress_model.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:flutter_application_1/services/course_service.dart';
import 'package:get/get.dart';

class CourseController extends GetxController {
  final CourseService courseService = CourseService(Get.find<AuthService>());
  final RxList _courseCategories = <String>[].obs;
  final RxList _rangeCourseDuration = <RangeCourseDuration>[].obs;
  final RxBool _isNoConnection = false.obs;
  var courses = <Course>[].obs;
  var userCourse = <Course>[].obs;
  var userProgress = <UserCourseProgress>[].obs; // Store user progress
  var isLoading = false.obs;

  RxBool get isNoConnection => (_isNoConnection.value).obs;
  RxList get courseCategories => (_courseCategories.value).obs;
  RxList get rangeCourseDuration => (_rangeCourseDuration.value).obs;

  @override
  void onInit() {
    super.onInit();
    print("Course Controller initialized!");
    fetchCourses();
    fetchCourseCategories();
    fetchCourseDurationList();
  }

  void refreshData() => fetchCourses();
  void fetchCourseCategories() => _courseCategories(categoriesList);
  void fetchCourseDurationList() => _rangeCourseDuration(courseDurationList);

  void fetchCourses() async {
    isLoading(true);
    try {
      print("Fetching courses...");
      _isNoConnection(false);
      courses.value = await courseService.fetchCourse();
    } catch (err) {
      _isNoConnection(true);
      err.printError();
    } finally {
      isLoading(false);
    }
  }

  void fetchUserProgress() async {
    isLoading(true);
    try {
      print("Fetching user progress...");
      _isNoConnection(false);
      // Mocked progress fetching (replace with API call)
      userProgress.value = [
        UserCourseProgress(
          id: 1,
          courseId: 101,
          lessonId: 5,
          isCompleted: false,
          progress: 45,
          imageUrl: null,
        ),
      ];
    } catch (err) {
      _isNoConnection(true);
      err.printError();
    } finally {
      isLoading(false);
    }
  }

  double get learnedToday {
    return userProgress.fold(0, (sum, progress) => sum + progress.progress);
  }
}
