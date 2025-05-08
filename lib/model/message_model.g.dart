// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      sender: json['sender'] as String,
      senderProfile: json['senderProfile'] as String?,
      time: json['time'] as String,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'sender': instance.sender,
      'senderProfile': instance.senderProfile,
      'time': instance.time,
      'imageUrl': instance.imageUrl,
    };
