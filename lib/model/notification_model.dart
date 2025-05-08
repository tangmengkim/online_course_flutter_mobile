import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String sender;
  final String time;
  final String type;

  const NotificationModel(
      {required this.id,
      required this.title,
      required this.body,
      required this.sender,
      required this.time,
      required this.type});

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
