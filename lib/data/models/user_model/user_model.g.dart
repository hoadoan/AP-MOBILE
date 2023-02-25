// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      address: json['address'] as String?,
      birthDate: json['birthDate'] as String?,
      email: json['email'] as String,
      grade: json['grade'] as String?,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      school: json['school'] as String?,
      accessToken: json['accessToken'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'address': instance.address,
      'birthDate': instance.birthDate,
      'email': instance.email,
      'grade': instance.grade,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'school': instance.school,
      'accessToken': instance.accessToken,
    };
