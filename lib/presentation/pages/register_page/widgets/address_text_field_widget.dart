import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_logics/bloc/register/register_page_bloc.dart';
import 'package:flutter_application_1/business_logics/bloc/register/register_page_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

import '../../../custom_widgets/custom_text_field.dart';

class AddressTextFieldWidget extends StatelessWidget {
  const AddressTextFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegisterPageBloc registerPageBloc =
        BlocProvider.of<RegisterPageBloc>(context);

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
                  'Address:',
                ),
              ],
            ),
          ),
        ),
        CustomTextField(
          onInputText: (text) {
            registerPageBloc.add(AddressValidationEvent());
          },
          inputType: TextInputType.name,
          inputAction: TextInputAction.done,
          elevation: 0.0,
          textEditingController: registerPageBloc.addressEditingController,
          focusNode: registerPageBloc.addressFocusNode,
          hintText: 'Type your address...',
          minLines: 4,
          maxLines: 4,
        ),
      ],
    );
  }
}
