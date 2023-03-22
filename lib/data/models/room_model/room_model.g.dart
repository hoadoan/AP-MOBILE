// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomModel _$RoomModelFromJson(Map<String, dynamic> json) => RoomModel(
      email: json['email'] as String,
      imageId: json['imageId'] as String,
      labelId: json['labelId'] as String,
      name: json['name'] as String,
      roomId: json['roomId'] as String,
      id: Map<String, String>.from(json['_id'] as Map),
      trainURL: json['trainURL'] as String?,
    );

Map<String, dynamic> _$RoomModelToJson(RoomModel instance) => <String, dynamic>{
      'email': instance.email,
      'imageId': instance.imageId,
      'labelId': instance.labelId,
      'name': instance.name,
      'roomId': instance.roomId,
      'trainURL': instance.trainURL,
      '_id': instance.id,
    };
