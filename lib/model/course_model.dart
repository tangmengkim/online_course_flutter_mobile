import 'package:json_annotation/json_annotation.dart';

part 'course_model.g.dart';

@JsonSerializable()
class Course {
  final int id;
  final String title;
  final String author;
  final String profileImageUrl;
  final double price;
  final int hours;
  final int totalLessons;
  final String category;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  Course({
    required this.id,
    required this.title,
    required this.author,
    required this.profileImageUrl,
    required this.price,
    required this.hours,
    required this.totalLessons,
    required this.category,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  // JSON serialization methods
  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);
}
//flutter pub run build_runner build --delete-conflicting-outputs
