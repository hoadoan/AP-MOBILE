import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/data/models/user_model/user_model.dart';

class SignInPageState extends Equatable {
  final UserModel? userModel;

  const SignInPageState({this.userModel});

  SignInPageState updateStateWith({UserModel? userModel}) {
    return SignInPageState(userModel: userModel ?? this.userModel);
  }

  @override
  List<Object?> get props => [
        userModel,
      ];
}
