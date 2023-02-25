import 'package:flutter/material.dart';

abstract class UserProfilePageEvent {}

class InitEvent extends UserProfilePageEvent {}

class FullNameValidationEvent extends UserProfilePageEvent {}

class PhoneValidationEvent extends UserProfilePageEvent {}

class SchoolValidationEvent extends UserProfilePageEvent {}

class GradeValidationEvent extends UserProfilePageEvent {}

class AddressValidationEvent extends UserProfilePageEvent {}

class BackgroundTapEvent extends UserProfilePageEvent {}

class SignOutEvent extends UserProfilePageEvent {
  final Function() navigatorToSignInPage;

  SignOutEvent({
    required this.navigatorToSignInPage,
  });
}

class SaveButtonEvent extends UserProfilePageEvent {
  final BuildContext buildContext;
  SaveButtonEvent({
    required this.buildContext,
  });
}

class GradeChangeEvent extends UserProfilePageEvent {
  final String grade;
  GradeChangeEvent({
    required this.grade,
  });
}
