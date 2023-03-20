import 'dart:convert';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/data/models/detect_model/detect_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'detect_result_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DetectResultModel extends Equatable {
  final List<DetectModel> detections;
  final String result;
  @JsonKey(includeFromJson: false, includeToJson: false)
  late final Uint8List imageByte;

  DetectResultModel({
    required this.detections,
    required this.result,
  }) {
    // List<int> code = result.codeUnits;
    // imageByte = Uint8List.fromList(code);
    imageByte = base64Decode(result);
  }

  DetectResultModel copyWith({
    List<DetectModel>? detections,
    String? result,
  }) {
    return DetectResultModel(
      detections: detections ?? this.detections,
      result: result ?? this.result,
    );
  }

  @override
  List<Object?> get props => [];

  factory DetectResultModel.fromJson(Map<String, dynamic> json) =>
      _$DetectResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$DetectResultModelToJson(this);
}
