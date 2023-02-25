import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/data/models/user_model/user_model.dart';

abstract class SignInPageEvent {}

class SignInButtonEvent extends SignInPageEvent {
  final BuildContext context;
  SignInButtonEvent(this.context);
}

class SignInEvent extends SignInPageEvent {
  final UserModel userModel;
  SignInEvent(this.userModel);
}

class SignOutButtonEvent extends SignInPageEvent {}
