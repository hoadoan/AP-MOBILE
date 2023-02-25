import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_logics/bloc/register/register_page_event.dart';
import 'package:flutter_application_1/business_logics/bloc/register/register_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

import '../../../../business_logics/bloc/register/register_page_bloc.dart';
import '../../../custom_widgets/custom_text_field.dart';

class SchoolTextFieldWidget extends StatelessWidget {
  const SchoolTextFieldWidget({Key? key}) : super(key: key);

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
                    Icon(
                      PhosphorIcons.chalkboard_fill,
                    ),
                    Text(
                      "School:",
                    ),
                  ],
                ),
              ),
            ),
            CustomTextField(
              onInputText: (text) {
                registerPageBloc.add(SchoolValidationEvent());
              },
              inputType: TextInputType.name,
              inputAction: TextInputAction.next,
              elevation: 0.0,
              textEditingController:
                  registerPageBloc.schoolTextEditingController,
              focusNode: registerPageBloc.schoolFocusNode,
              hintText: "Type your school...",
            ),
          ],
        );
      },
    );
  }
}
