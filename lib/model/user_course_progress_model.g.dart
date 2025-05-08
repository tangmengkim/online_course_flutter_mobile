// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_course_progress_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCourseProgress _$UserCourseProgressFromJson(Map<String, dynamic> json) =>
    UserCourseProgress(
      id: (json['id'] as num).toInt(),
      courseId: (json['courseId'] as num).toInt(),
      lessonId: (json['lessonId'] as num).toInt(),
      isCompleted: json['isCompleted'] as bool,
      progress: (json['progress'] as num).toInt(),
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$UserCourseProgressToJson(UserCourseProgress instance) =>
    <String, dynamic>{
      'id': instance.id,
      'courseId': instance.courseId,
      'lessonId': instance.lessonId,
      'isCompleted': instance.isCompleted,
      'progress': instance.progress,
      'imageUrl': instance.imageUrl,
    };
