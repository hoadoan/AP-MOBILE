import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_logics/bloc/sign_in/sign_in_page_event.dart';
import 'package:flutter_application_1/business_logics/bloc/sign_in/sign_in_page_state.dart';
import 'package:flutter_application_1/data/api_handling/user_service.dart';
import 'package:flutter_application_1/data/models/user_model/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../presentation/route_management/route_name.dart';

class SignInPageBloc extends Bloc<SignInPageEvent, SignInPageState> {
  final UserService _userService = UserService();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  SignInPageBloc() : super(const SignInPageState()) {
    on<SignInButtonEvent>(_onSignInButtonEvent);
    on<SignOutButtonEvent>(_onSignOutButtonEvent);
    on<SignInEvent>(_onSignInEvent);
  }

  _onSignInButtonEvent(
      SignInButtonEvent event, Emitter<SignInPageState> emit) async {
    GoogleSignInAccount? googleSignInAccount =
        await _userService.signInWithGoogle();

    if (googleSignInAccount != null) {
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      User? user =
          await _userService.signInToFirebase(googleSignInAuthentication);

      if (user != null) {
        UserModel? userModel =
            await _userService.signInToApp(idToken: await user.getIdToken());
        if (userModel != null) {
          emit(
            state.updateStateWith(
              userModel: userModel.copyWith(
                firebaseUser: user,
              ),
            ),
          );
          await _storage.write(key: 'jwt', value: userModel.accessToken);

          Navigator.pushNamedAndRemoveUntil(
            event.context,
            RouteNames.kHomePageRoute,
            (route) => false,
          );
        } else {
          Navigator.pushNamedAndRemoveUntil(
              event.context, RouteNames.kRegisterPageRoute, (route) => false,
              arguments: user);
        }
      }
    }
  }

  _onSignOutButtonEvent(
      SignOutButtonEvent event, Emitter<SignInPageState> emit) {
    _userService.signOutFirebase();
    emit(state.updateStateWith(userModel: null));
  }

  _onSignInEvent(SignInEvent event, Emitter<SignInPageState> emit) {
    emit(state.updateStateWith(userModel: event.userModel));
    log(event.userModel.name);
    log(state.userModel!.name);
  }
}
