import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_logics/bloc/user_profile/user_profile_page_bloc.dart';
import 'package:flutter_application_1/business_logics/bloc/user_profile/user_profile_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

import '../../../../business_logics/bloc/user_profile/user_profile_page_event.dart';
import '../../../custom_widgets/custom_text_field.dart';

class PhoneNumberTextFieldWidget extends StatelessWidget {
  const PhoneNumberTextFieldWidget({Key? key}) : super(key: key);

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
                    Icon(
                      PhosphorIcons.phone_fill,
                    ),
                    Text(
                      "Phone number:",
                    ),
                  ],
                ),
              ),
            ),
            CustomTextField(
              onInputText: (_) {
                userProfilePageBloc.add(PhoneValidationEvent());
              },
              inputType: TextInputType.phone,
              inputAction: TextInputAction.next,
              elevation: 0.0,
              textEditingController:
                  userProfilePageBloc.phoneNumberTextEditingController,
              focusNode: userProfilePageBloc.phoneNumberFocusNode,
              hintText: 'Type your phone number...',
            ),
          ],
        );
      },
    );
  }
}
