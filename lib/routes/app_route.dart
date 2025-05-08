import 'package:flutter_application_1/middleware/auth_middleware.dart';
import 'package:flutter_application_1/views/pages/main_screen.dart';
import 'package:flutter_application_1/views/pages/search/search_screen.dart';
import 'package:get/get.dart';

import '../auth_binding.dart';
import '../views/pages/signin_screen.dart';
import '../views/pages/signup_screen.dart';

class AppRoute {
  static final routes = [
    GetPage(
      name: '/signin',
      page: () => SignInScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: '/signup',
      page: () => SignupScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: '/home',
      page: () => Mainscreen(),
      binding: AuthBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/search',
      page: () => SearchScreen(),
      binding: AuthBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
