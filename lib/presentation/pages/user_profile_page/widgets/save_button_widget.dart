import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_logics/bloc/user_profile/user_profile_page_bloc.dart';
import 'package:flutter_application_1/business_logics/bloc/user_profile/user_profile_page_state.dart';
import 'package:flutter_application_1/presentation/utilities/color_constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logics/bloc/user_profile/user_profile_page_event.dart';

class SaveButtonWidget extends StatelessWidget {
  const SaveButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 1,
          color: ColorConstant.kBlackColor.withOpacity(0.5),
        ),
        Container(
          alignment: Alignment.center,
          color: ColorConstant.kBlackColor.withOpacity(0.1),
          height: 70,
          child: BlocBuilder<UserProfilePageBloc, UserProfilePageState>(
            builder: (context, state) {
              return InkWell(
                onTap: () {
                  if (state.fullNameErrorMsg.isEmpty && state.isChange) {
                    BlocProvider.of<UserProfilePageBloc>(context)
                        .add(SaveButtonEvent(buildContext: context));
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 60),
                  decoration: BoxDecoration(
                    color: state.fullNameErrorMsg.isEmpty && state.isChange
                        ? const Color.fromARGB(255, 255, 161, 79)
                        : ColorConstant.kOrangeColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: state.fullNameErrorMsg.isEmpty && state.isChange
                            ? ColorConstant.kOrangeColor
                            : ColorConstant.kOrangeColor.withOpacity(0.3),
                        width: 1.5),
                  ),
                  child: Text(
                    'SAVE PROFILE',
                    style: TextStyle(
                      color: state.fullNameErrorMsg.isEmpty && state.isChange
                          ? ColorConstant.kWhiteColor
                          : ColorConstant.kWhiteColor.withOpacity(0.7),
                      fontSize: 18,
                      letterSpacing: 3,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
