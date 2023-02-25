import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logics/bloc/user_profile/user_profile_page_bloc.dart';
import '../../../../business_logics/bloc/user_profile/user_profile_page_event.dart';
import '../../../../business_logics/bloc/user_profile/user_profile_page_state.dart';
import '../../../custom_widgets/custom_text_field.dart';
import '../../../utilities/color_constant.dart';

class NameTextFieldWidget extends StatelessWidget {
  const NameTextFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProfilePageBloc userProfilePageBloc =
        BlocProvider.of<UserProfilePageBloc>(context);

    return BlocBuilder<UserProfilePageBloc, UserProfilePageState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: const [
                    Icon(Icons.person_pin_sharp),
                    Text(
                      "Full name:",
                    ),
                  ],
                ),
              ),
            ),
            CustomTextField(
              isEnabled: true,
              onInputText: (_) {
                userProfilePageBloc.add(FullNameValidationEvent());
              },
              inputType: TextInputType.name,
              inputAction: TextInputAction.next,
              elevation: 0.0,
              textEditingController:
                  userProfilePageBloc.nameTextEditingController,
              focusNode: userProfilePageBloc.nameFocusNode,
              hintText: 'Full name',
              borderColor: state.fullNameErrorMsg.isEmpty
                  ? null
                  : ColorConstant.kRedColor,
            ),
            Visibility(
              visible: userProfilePageBloc.state.fullNameErrorMsg.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    userProfilePageBloc.state.fullNameErrorMsg,
                    style: const TextStyle(
                      color: ColorConstant.kRedColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
