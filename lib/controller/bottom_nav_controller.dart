import 'package:flutter_application_1/views/pages/search/search_screen.dart';
import 'package:get/get.dart';

class BottomNavController extends GetxController {
  var currentIndex = 0.obs;

  void changeIndex(int index) {
    if (index == 2) {
      Get.to(() => SearchScreen()); // Navigate without changing the state
    } else {
      currentIndex.value = index;
    }
  }
}
