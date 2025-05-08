import 'package:json_annotation/json_annotation.dart';

part 'lesson_model.g.dart';

@JsonSerializable()
class LessonModel {
  final int id;
  final int courseId;
  final int lessonNumber;
  final String title;
  final String videoUrl;
  final int duration;
  final bool isLocked;
  final DateTime createdAt;
  final DateTime updatedAt;
  LessonModel({
    required this.id,
    required this.courseId,
    required this.lessonNumber,
    required this.title,
    required this.videoUrl,
    required this.duration,
    required this.isLocked,
    required this.createdAt,
    required this.updatedAt,
  });

  // JSON serialization methods
  factory LessonModel.fromJson(Map<String, dynamic> json) =>
      _$LessonModelFromJson(json);

  Map<String, dynamic> toJson() => _$LessonModelToJson(this);
}
//flutter pub run build_runner build --delete-conflicting-outputs
