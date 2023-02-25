import 'package:flutter/widgets.dart';

abstract class RegisterPageEvent {}

class FullNameValidationEvent extends RegisterPageEvent {}

class PhoneValidationEvent extends RegisterPageEvent {}

class SchoolValidationEvent extends RegisterPageEvent {}

class GradeValidationEvent extends RegisterPageEvent {}

class AddressValidationEvent extends RegisterPageEvent {}

class BackgroundTapEvent extends RegisterPageEvent {}

class SignOutEvent extends RegisterPageEvent {
  final Function() navigatorToSignInPage;

  SignOutEvent({
    required this.navigatorToSignInPage,
  });
}

class ContinueButtonEvent extends RegisterPageEvent {
  final BuildContext buildContext;
  ContinueButtonEvent({
    required this.buildContext,
  });
}

class GradeChangeEvent extends RegisterPageEvent {
  final String grade;
  GradeChangeEvent({
    required this.grade,
  });
}
