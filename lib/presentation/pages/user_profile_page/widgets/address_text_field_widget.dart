import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_logics/bloc/user_profile/user_profile_page_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

import '../../../../business_logics/bloc/user_profile/user_profile_page_bloc.dart';
import '../../../custom_widgets/custom_text_field.dart';

class AddressTextFieldWidget extends StatelessWidget {
  const AddressTextFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProfilePageBloc userProfilePageBloc =
        BlocProvider.of<UserProfilePageBloc>(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: const [
                Icon(
                  PhosphorIcons.map_pin_fill,
                ),
                Text(
                  "Address:",
                ),
              ],
            ),
          ),
        ),
        CustomTextField(
          onInputText: (text) {
            userProfilePageBloc.add(AddressValidationEvent());
          },
          inputType: TextInputType.name,
          inputAction: TextInputAction.done,
          elevation: 0.0,
          textEditingController: userProfilePageBloc.addressEditingController,
          focusNode: userProfilePageBloc.addressFocusNode,
          hintText: 'Type your address...',
          minLines: 4,
          maxLines: 4,
        ),
      ],
    );
  }
}
