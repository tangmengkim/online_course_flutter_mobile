import 'package:flutter_application_1/views/customs/video_player_widget.dart';
import 'package:flutter_application_1/model/course_model.dart';
import 'package:flutter_application_1/model/lesson_model.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:flutter_application_1/services/lesson_service.dart';
import 'package:get/get.dart';

class CourseDetailController extends GetxController {
  final LessonService lessonService = LessonService(Get.find<AuthService>());
  final VideoController videoController = Get.put(VideoController());

  final Course course;
  final RxBool _isLoadingLesson = false.obs;
  final RxBool _isNoConnection = false.obs;
  RxBool isShowLesson = true.obs;
  RxBool isPlayLesson = false.obs;
  late RxList<LessonModel> lessonList = <LessonModel>[].obs;
  CourseDetailController(this.course);

  @override
  void onInit() {
    getLessonByCourseId();
    super.onInit();
  }

  void toggleVisible() {
    isShowLesson.toggle();
  }

  List<LessonModel> get getLessonList => lessonList;
  bool get isLoadingLesson => _isLoadingLesson.value;
  bool get isNoConnection => _isNoConnection.value;
  void getLessonByCourseId() async {
    try {
      _isNoConnection(false);
      _isLoadingLesson(true);
      lessonList.value = await lessonService.getLessonByCourseId(course.id);
      lessonList.sort(
        (a, b) => a.lessonNumber.compareTo(b.lessonNumber),
      );
    } catch (err) {
      _isNoConnection(true);
    } finally {
      _isLoadingLesson(false);
    }
  }

  void refreshLessonData() {
    _isNoConnection(false);
    _isLoadingLesson(true);
    getLessonByCourseId();
  }

  // void playLesson(LessonModel lesson) {
  //   if (isPlayLesson.isFalse) {
  //     isPlayLesson(true);
  //     videoController.initializeVideo(lesson);
  //   } else {
  //     togglePlayPause(lesson);
  //   }
  // }

  void togglePlayPause(LessonModel lesson) {
    videoController.togglePlayPause(lesson);
  }
}
