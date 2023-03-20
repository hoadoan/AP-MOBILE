// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detect_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetectModel _$DetectModelFromJson(Map<String, dynamic> json) => DetectModel(
      confidence: json['confidence'] as String,
      image: json['image'] as String,
      label: json['label'] as String,
    );

Map<String, dynamic> _$DetectModelToJson(DetectModel instance) =>
    <String, dynamic>{
      'confidence': instance.confidence,
      'image': instance.image,
      'label': instance.label,
    };
