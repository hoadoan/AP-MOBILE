import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_application_1/business_logics/bloc/user_profile/user_profile_page_bloc.dart';
import 'package:flutter_application_1/presentation/custom_widgets/background_widget.dart';
import 'package:flutter_application_1/presentation/pages/user_profile_page/widgets/address_text_field_widget.dart';
import 'package:flutter_application_1/presentation/pages/user_profile_page/widgets/grade_text_field_widget.dart';
import 'package:flutter_application_1/presentation/pages/user_profile_page/widgets/loading_widget.dart';
import 'package:flutter_application_1/presentation/pages/user_profile_page/widgets/mail_text_field_widget.dart';
import 'package:flutter_application_1/presentation/pages/user_profile_page/widgets/name_text_field_widget.dart';
import 'package:flutter_application_1/presentation/pages/user_profile_page/widgets/phone_number_text_field.dart';
import 'package:flutter_application_1/presentation/pages/user_profile_page/widgets/save_button_widget.dart';
import 'package:flutter_application_1/presentation/pages/user_profile_page/widgets/school_text_field_widget.dart';

import '../../../business_logics/bloc/user_profile/user_profile_page_event.dart';
import 'widgets/avatar_widget.dart';

class UserProfilePage extends StatelessWidget {
  final Function() onTapBack;

  const UserProfilePage({
    Key? key,
    required this.onTapBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const BackgroundWidget(),
            GestureDetector(
              onTap: () {
                context.read<UserProfilePageBloc>().add(BackgroundTapEvent());
              },
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          AvatarContainerWidget(onTapBack: onTapBack),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: const [
                                SizedBox(height: 10),
                                NameTextFieldWidget(),
                                SizedBox(height: 10),
                                MailTextFieldWidget(),
                                SizedBox(height: 10),
                                PhoneNumberTextFieldWidget(),
                                SizedBox(height: 10),
                                SchoolTextFieldWidget(),
                                SizedBox(height: 10),
                                GradeTextFieldWidget(),
                                SizedBox(height: 10),
                                AddressTextFieldWidget(),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SaveButtonWidget(),
                ],
              ),
            ),
            const LoadingWidget(),
          ],
        ),
      ),
    );
  }
}
