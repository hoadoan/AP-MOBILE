import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_logics/bloc/home/home_page_bloc.dart';
import 'package:flutter_application_1/business_logics/bloc/home/home_page_event.dart';
import 'package:flutter_application_1/business_logics/bloc/home/home_page_state.dart';
import 'package:flutter_application_1/presentation/utilities/color_constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../route_management/route_name.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return BlocBuilder<HomePageBloc, HomePageState>(
      buildWhen: (previous, current) => true,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                RouteNames.kUserProfilePageRoute,
                arguments: () {
                  context.read<HomePageBloc>().add(InitEvent());
                },
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24.w,
                  backgroundColor: ColorConstant.kOrangeColor,
                  child: CircleAvatar(
                    radius: 22.w,
                    backgroundColor: ColorConstant.kWhiteColor,
                    child: CircleAvatar(
                      radius: 19.5.w,
                      backgroundImage: user != null
                          ? NetworkImage(
                              user.photoURL ?? '',
                            )
                          : null,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    !state.isLoadData
                        ? Text(
                            'Good Afternoon, ${state.userModel?.name}!',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : SizedBox(
                            height: 18.h,
                          ),
                    Text(
                      'Tap here to edit personal data',
                      style: TextStyle(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
