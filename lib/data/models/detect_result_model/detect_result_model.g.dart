// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detect_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetectResultModel _$DetectResultModelFromJson(Map<String, dynamic> json) =>
    DetectResultModel(
      detections: (json['detections'] as List<dynamic>)
          .map((e) => DetectModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      result: json['result'] as String,
    );

Map<String, dynamic> _$DetectResultModelToJson(DetectResultModel instance) =>
    <String, dynamic>{
      'detections': instance.detections.map((e) => e.toJson()).toList(),
      'result': instance.result,
    };
