// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      author: json['author'] as String,
      profileImageUrl: json['profileImageUrl'] as String,
      price: (json['price'] as num).toDouble(),
      hours: (json['hours'] as num).toInt(),
      totalLessons: (json['totalLessons'] as num).toInt(),
      category: json['category'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'profileImageUrl': instance.profileImageUrl,
      'price': instance.price,
      'hours': instance.hours,
      'totalLessons': instance.totalLessons,
      'category': instance.category,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
