import 'dart:convert';
import 'package:flutter_application_1/model/course_model.dart';
import 'package:flutter_application_1/services/auth_service.dart';

class CourseService {
  final AuthService authService;
  final String courseEndpoint = "courses/get";

  CourseService(this.authService);

  Future<List<Course>> fetchCourse({int page = 1, int perPage = 10}) async {
    final res = await authService.getWithAuth(
      '$courseEndpoint/?page=$page&per_page=$perPage',
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);

      if (data is Map<String, dynamic> && data.containsKey('data')) {
        final courses = data['data'] as List;
        return courses
            .map((e) => Course.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception("Courses key not found in response");
      }
    } else {
      throw Exception("Failed to load course");
    }
  }
}
