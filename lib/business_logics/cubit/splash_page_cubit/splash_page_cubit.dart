// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_logics/cubit/splash_page_cubit/splash_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../data/api_handling/user_service.dart';
import '../../../data/models/user_model/user_model.dart';
import '../../../presentation/route_management/route_name.dart';

class SplashPageCubit extends Cubit<SplashPageState> {
  SplashPageCubit() : super(SplashPageState());

  int _seconds = 0;

  void onReady(BuildContext context) {
    _startTimer(context);
  }

  void _startTimer(BuildContext context) async {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      _seconds += 1;
      if (_seconds >= 3) {
        timer.cancel();

        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          final UserService userService = UserService();

          UserModel? userModel =
              await userService.signInToApp(idToken: await user.getIdToken());
          if (userModel != null) {
            const FlutterSecureStorage storage = FlutterSecureStorage();
            await storage.write(key: 'jwt', value: userModel.accessToken);

            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteNames.kHomePageRoute,
              (route) => false,
            );
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, RouteNames.kRegisterPageRoute, (route) => false,
                arguments: user);
          }
        } else {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteNames.kSignInPageRoute,
            (page) => false,
          );
        }
      }
    });
  }

  void onScreenTap() {
    _seconds += 10;
  }
}
