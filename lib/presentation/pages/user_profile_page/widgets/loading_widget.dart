import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logics/bloc/user_profile/user_profile_page_bloc.dart';
import '../../../../business_logics/bloc/user_profile/user_profile_page_state.dart';
import '../../../custom_widgets/blur_widget.dart';
import '../../../utilities/color_constant.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfilePageBloc, UserProfilePageState>(
      builder: (context, state) {
        return Visibility(
          visible: state.isWaitingUpdateProfile || state.isInit,
          child: Stack(
            children: [
              const CustomBlurWidget(sigmaX: 3, sigmaY: 3),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      color: ColorConstant.kOrangeColor,
                    ),
                    if (state.isWaitingUpdateProfile)
                      const SizedBox(
                        height: 10,
                      ),
                    if (state.isWaitingUpdateProfile)
                      const Text(
                        'Waiting for update user profile...',
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
