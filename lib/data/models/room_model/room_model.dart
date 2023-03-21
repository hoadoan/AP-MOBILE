import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'room_model.g.dart';

@JsonSerializable(explicitToJson: false)
class RoomModel extends Equatable {
  final String email;
  final String imageId;
  final String labelId;
  final String name;
  final String roomId;
  @JsonKey(name: '_id')
  final Map<String, String> id;

  const RoomModel({
    required this.email,
    required this.imageId,
    required this.labelId,
    required this.name,
    required this.roomId,
    required this.id,
  });

  @override
  List<Object?> get props => [];

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomModelToJson(this);
}
