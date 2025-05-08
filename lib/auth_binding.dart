import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:get/get.dart';

import 'controller/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<AuthService>(() => AuthService(Get.find()));
  }
}
