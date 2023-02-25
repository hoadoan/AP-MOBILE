import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: false)
class UserModel extends Equatable {
  final String? address;
  final String? birthDate;
  final String email;
  final String? grade;
  final String name;
  final String? phoneNumber;
  final String? school;
  final String? accessToken;

  const UserModel({
    this.address,
    this.birthDate,
    required this.email,
    this.grade,
    required this.name,
    this.phoneNumber,
    this.school,
    this.accessToken,
  });

  UserModel copyWith({
    User? firebaseUser,
    String? address,
    String? birthDate,
    String? email,
    String? grade,
    String? name,
    String? phoneNumber,
    String? school,
    String? accessToken,
  }) {
    return UserModel(
      email: email ?? this.email,
      name: name ?? this.name,
      address: address ?? this.address,
      birthDate: birthDate ?? this.birthDate,
      grade: grade ?? this.grade,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      school: school ?? this.school,
      accessToken: accessToken ?? this.accessToken,
    );
  }

  @override
  List<Object?> get props => [];

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
