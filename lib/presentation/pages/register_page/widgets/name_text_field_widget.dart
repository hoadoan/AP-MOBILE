import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_logics/bloc/register/register_page_bloc.dart';
import 'package:flutter_application_1/business_logics/bloc/register/register_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../business_logics/bloc/register/register_page_event.dart';
import '../../../custom_widgets/custom_text_field.dart';
import '../../../utilities/color_constant.dart';

class NameTextFieldWidget extends StatelessWidget {
  const NameTextFieldWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegisterPageBloc registerPageBloc =
        BlocProvider.of<RegisterPageBloc>(context);

    return BlocBuilder<RegisterPageBloc, RegisterPageState>(
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
                      'Full name*:',
                    ),
                  ],
                ),
              ),
            ),
            CustomTextField(
              isEnabled: true,
              onInputText: (_) {
                registerPageBloc.add(FullNameValidationEvent());
              },
              inputType: TextInputType.name,
              inputAction: TextInputAction.next,
              elevation: 0.0,
              textEditingController: registerPageBloc.nameTextEditingController,
              focusNode: registerPageBloc.nameFocusNode,
              hintText: 'Full name',
              borderColor: state.fullNameErrorMsg.isEmpty
                  ? null
                  : ColorConstant.kRedColor,
            ),
            Visibility(
              visible: registerPageBloc.state.fullNameErrorMsg.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    registerPageBloc.state.fullNameErrorMsg,
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
