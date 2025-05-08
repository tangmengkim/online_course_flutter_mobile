// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonModel _$LessonModelFromJson(Map<String, dynamic> json) => LessonModel(
      id: (json['id'] as num).toInt(),
      courseId: (json['courseId'] as num).toInt(),
      lessonNumber: (json['lessonNumber'] as num).toInt(),
      title: json['title'] as String,
      videoUrl: json['videoUrl'] as String,
      duration: (json['duration'] as num).toInt(),
      isLocked: json['isLocked'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$LessonModelToJson(LessonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'courseId': instance.courseId,
      'lessonNumber': instance.lessonNumber,
      'title': instance.title,
      'videoUrl': instance.videoUrl,
      'duration': instance.duration,
      'isLocked': instance.isLocked,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
