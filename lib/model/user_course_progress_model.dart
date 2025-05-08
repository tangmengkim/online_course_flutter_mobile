import 'package:json_annotation/json_annotation.dart';

part 'user_course_progress_model.g.dart';

@JsonSerializable()
class UserCourseProgress {
  final int id;
  final int courseId;
  final int lessonId;
  final bool isCompleted;
  final int progress;
  final String? imageUrl;

  const UserCourseProgress({
    required this.id,
    required this.courseId,
    required this.lessonId,
    required this.isCompleted,
    required this.progress,
    this.imageUrl,
  });

  factory UserCourseProgress.fromJson(Map<String, dynamic> json) =>
      _$UserCourseProgressFromJson(json);

  Map<String, dynamic> toJson() => _$UserCourseProgressToJson(this);
}
