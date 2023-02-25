import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_logics/bloc/home/home_page_bloc.dart';
import 'package:flutter_application_1/business_logics/bloc/home/home_page_event.dart';
import 'package:flutter_application_1/business_logics/bloc/home/home_page_state.dart';
import 'package:flutter_application_1/presentation/utilities/color_constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                  radius: 24,
                  backgroundColor: ColorConstant.kOrangeColor,
                  child: CircleAvatar(
                    radius: 22,
                    backgroundColor: ColorConstant.kWhiteColor,
                    child: CircleAvatar(
                      backgroundImage: user != null
                          ? NetworkImage(
                              user.photoURL ?? '',
                            )
                          : null,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    !state.isLoadData
                        ? Text(
                            'Good Afternoon, ${state.userModel?.name}!',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : const SizedBox(
                            height: 18,
                          ),
                    const Text(
                      'Tap here to edit personal data',
                      style: TextStyle(
                        fontSize: 9,
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
