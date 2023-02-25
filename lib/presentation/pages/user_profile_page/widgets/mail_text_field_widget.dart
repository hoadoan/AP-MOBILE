import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

import '../../../../business_logics/bloc/user_profile/user_profile_page_bloc.dart';
import '../../../../business_logics/bloc/user_profile/user_profile_page_state.dart';
import '../../../custom_widgets/custom_text_field.dart';

class MailTextFieldWidget extends StatelessWidget {
  const MailTextFieldWidget({Key? key}) : super(key: key);

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
                      PhosphorIcons.envelope_fill,
                    ),
                    Text(
                      "Email:",
                    ),
                  ],
                ),
              ),
            ),
            CustomTextField(
              isEnabled: false,
              onInputText: (text) {},
              inputType: TextInputType.name,
              inputAction: TextInputAction.next,
              elevation: 0.0,
              textEditingController:
                  userProfilePageBloc.mailTextEditingController,
              focusNode: FocusNode(),
              hintText: "First Name",
            ),
          ],
        );
      },
    );
  }
}
