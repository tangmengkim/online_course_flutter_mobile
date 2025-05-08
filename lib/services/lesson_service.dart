import 'dart:convert';

import 'package:flutter_application_1/model/lesson_model.dart';
import 'package:flutter_application_1/services/auth_service.dart';

class LessonService {
  final AuthService authService;
  final String endpoint = "lessons";
  LessonService(this.authService);

  Future<List<LessonModel>> getLessonByCourseId(int courseId) async {
    final res = await authService.getWithAuth("$endpoint/course/$courseId");
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      if (data is Map<String, dynamic> && data.containsKey("data")) {
        final lesson = data['data'] as List;
        return lesson
            .map((e) => LessonModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (data is List<dynamic>) {
        return data
            .map((e) => LessonModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception("lesson not found in response");
      }
    } else {
      throw Exception("Failed to load lesson");
    }
  }
}
