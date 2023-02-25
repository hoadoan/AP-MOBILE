import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';

import 'package:flutter_application_1/business_logics/bloc/user_profile/user_profile_page_bloc.dart';

import '../../../../business_logics/bloc/user_profile/user_profile_page_event.dart';
import '../../../route_management/route_name.dart';
import '../../../utilities/color_constant.dart';

class AvatarContainerWidget extends StatelessWidget {
  final Function() onTapBack;

  const AvatarContainerWidget({
    Key? key,
    required this.onTapBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        ClipPath(
          clipper: ProsteBezierCurve(
            position: ClipPosition.bottom,
            list: [
              BezierCurveSection(
                start: const Offset(0, 125),
                top: Offset(deviceWidth / 4, 145),
                end: Offset(deviceWidth / 2, 125),
              ),
              BezierCurveSection(
                start: Offset(deviceWidth / 2, 125),
                top: Offset(deviceWidth / 4 * 3, 100),
                end: Offset(deviceWidth, 120),
              ),
            ],
          ),
          child: Image.network(
            'https://i.pinimg.com/564x/bf/6f/70/bf6f70ce03bc014ea6b39b5724baf001.jpg',
            height: 150,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            alignment: Alignment.bottomCenter,
          ),
        ),
        Container(
          height: 150,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      onTapBack();
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      PhosphorIcons.x_bold,
                      color: ColorConstant.kOrangeColor,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context
                          .read<UserProfilePageBloc>()
                          .add(SignOutEvent(navigatorToSignInPage: () {
                        Navigator.pushNamedAndRemoveUntil(context,
                            RouteNames.kSignInPageRoute, (route) => false);
                      }));
                    },
                    child: const Icon(
                      PhosphorIcons.sign_out,
                      color: ColorConstant.kOrangeColor,
                    ),
                  ),
                ],
              ),
              const AvatarWidget(
                sizeMultiple: 1.2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AvatarWidget extends StatelessWidget {
  final double sizeMultiple;

  const AvatarWidget({Key? key, this.sizeMultiple = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30 * sizeMultiple,
      backgroundColor: ColorConstant.kOrangeColor,
      child: CircleAvatar(
        radius: 28 * sizeMultiple,
        backgroundColor: ColorConstant.kWhiteColor,
        child: CircleAvatar(
          radius: 25 * sizeMultiple,
          backgroundImage: NetworkImage(
            FirebaseAuth.instance.currentUser!.photoURL ?? '',
          ),
        ),
      ),
    );
  }
}
