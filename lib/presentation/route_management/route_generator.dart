import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_logics/bloc/home/home_page_bloc.dart';
import 'package:flutter_application_1/business_logics/bloc/identify/identify_page_bloc.dart';
import 'package:flutter_application_1/business_logics/bloc/register/register_page_bloc.dart';
import 'package:flutter_application_1/business_logics/bloc/register/register_page_state.dart';
import 'package:flutter_application_1/business_logics/bloc/sign_in/sign_in_page_bloc.dart';
import 'package:flutter_application_1/business_logics/bloc/training/training_page_bloc.dart';
import 'package:flutter_application_1/business_logics/bloc/user_profile/user_profile_page_bloc.dart';
import 'package:flutter_application_1/business_logics/bloc/user_profile/user_profile_page_state.dart';
import 'package:flutter_application_1/presentation/pages/custom_photo_view_page/custom_photo_view_page.dart';
import 'package:flutter_application_1/presentation/pages/home_page/home_page.dart';
import 'package:flutter_application_1/presentation/pages/identify_page/identify_page.dart';
import 'package:flutter_application_1/presentation/pages/register_page/register_page.dart';
import 'package:flutter_application_1/presentation/pages/room_list_view_page/room_list_view_page.dart';
import 'package:flutter_application_1/presentation/pages/user_profile_page/user_profile_page.dart';
import 'package:flutter_application_1/presentation/route_management/route_name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logics/cubit/splash_page_cubit/splash_page_cubit.dart';
import '../pages/sign_in_page/sign_in_page.dart';
import '../pages/splash_page/splash_page.dart';
import '../pages/training_page/training_page.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.kInitialRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => SplashPageCubit(),
            child: const SplashPage(),
          ),
        );
      case RouteNames.kSignInPageRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => SignInPageBloc(),
            child: const SignInPage(),
          ),
        );
      case RouteNames.kHomePageRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => HomePageBloc(),
            child: const HomePage(),
          ),
        );
      case RouteNames.kIdentifyPageRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<IdentifyPageBLoc>(
            create: (context) => IdentifyPageBLoc(),
            child: const IdentifyPage(),
          ),
        );
      case RouteNames.kUserProfilePageRoute:
        // UserModel userModel = routeSettings.arguments as UserModel;
        Function() onTapBack = routeSettings.arguments as Function();
        return MaterialPageRoute(
          builder: (context) => BlocProvider<UserProfilePageBloc>(
            create: (context) => UserProfilePageBloc(
              const UserProfilePageState(),
            ),
            child: UserProfilePage(onTapBack: onTapBack),
          ),
        );
      case RouteNames.kCustomPhotoViewPageRoute:
        Uint8List byteData = routeSettings.arguments as Uint8List;
        return MaterialPageRoute(
          builder: (context) => CustomPhotoViewPage(byteData: byteData),
        );
      case RouteNames.kRegisterPageRoute:
        User firebaseUser = routeSettings.arguments as User;
        return MaterialPageRoute(
          builder: (context) => BlocProvider<RegisterPageBloc>(
            create: (context) => RegisterPageBloc(
              RegisterPageState(firebaseUser: firebaseUser),
            ),
            child: const RegisterPage(),
          ),
        );
      case RouteNames.kRoomListPageRoute:
        return MaterialPageRoute(
          builder: (context) => const RoomListView(),
        );
      case RouteNames.kTrainingPageRoute:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<TrainingPageBloc>(
            create: (context) => TrainingPageBloc(),
            child: const TrainingPage(),
          ),
        );
      default:
        return null;
    }
  }
}
