import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_logics/bloc/register/register_page_bloc.dart';
import 'package:flutter_application_1/business_logics/bloc/register/register_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utilities/color_constant.dart';

class AvatarWidget extends StatelessWidget {
  final double sizeMultiple;

  const AvatarWidget({Key? key, this.sizeMultiple = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterPageBloc, RegisterPageState>(
      builder: (context, state) {
        User firebaseUser = state.firebaseUser;

        return InkWell(
          onTap: () async {},
          child: CircleAvatar(
            radius: 30 * sizeMultiple,
            backgroundColor: ColorConstant.kOrangeColor,
            child: CircleAvatar(
              radius: 28 * sizeMultiple,
              backgroundColor: ColorConstant.kWhiteColor,
              child: CircleAvatar(
                radius: 25 * sizeMultiple,
                backgroundImage: NetworkImage(
                  firebaseUser.photoURL ?? '',
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
