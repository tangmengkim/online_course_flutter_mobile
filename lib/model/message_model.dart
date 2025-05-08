import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel {
  final String id;
  final String title;
  final String body;
  final String sender;
  final String? senderProfile;
  final String time;
  final String? imageUrl;

  const MessageModel({
    required this.id,
    required this.title,
    required this.body,
    required this.sender,
    this.senderProfile,
    required this.time,
    this.imageUrl,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
