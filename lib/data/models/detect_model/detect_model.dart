import 'dart:convert';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'detect_model.g.dart';

@JsonSerializable(explicitToJson: false)
class DetectModel extends Equatable {
  final String confidence;
  final String image;
  final String label;
  @JsonKey(includeFromJson: false, includeToJson: false)
  late final Uint8List imageByte;

  DetectModel({
    required this.confidence,
    required this.image,
    required this.label,
  }) {
    // List<int> code = image.codeUnits;
    // log(image);
    // imageByte = Uint8List.fromList(code);
    imageByte = base64Decode(image);
  }

  DetectModel copyWith({
    String? confidence,
    String? image,
    String? label,
  }) {
    return DetectModel(
      confidence: confidence ?? this.confidence,
      image: image ?? this.image,
      label: label ?? this.label,
    );
  }

  @override
  List<Object?> get props => [];

  factory DetectModel.fromJson(Map<String, dynamic> json) =>
      _$DetectModelFromJson(json);

  Map<String, dynamic> toJson() => _$DetectModelToJson(this);
}
