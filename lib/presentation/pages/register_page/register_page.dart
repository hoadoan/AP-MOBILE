import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_logics/bloc/register/register_page_event.dart';
import 'package:flutter_application_1/business_logics/bloc/register/register_page_state.dart';
import 'package:flutter_application_1/presentation/custom_widgets/background_widget.dart';
import 'package:flutter_application_1/presentation/pages/register_page/widgets/continue_button_widget.dart';
import 'package:flutter_application_1/presentation/route_management/route_name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';

import '../../../business_logics/bloc/register/register_page_bloc.dart';
import '../../custom_widgets/blur_widget.dart';
import '../../utilities/color_constant.dart';
import 'widgets/address_text_field_widget.dart';
import 'widgets/avatar_widget.dart';
import 'widgets/grade_text_field_widget.dart';
import 'widgets/mail_text_field_widget.dart';
import 'widgets/name_text_field_widget.dart';
import 'widgets/phone_number_text_field.dart';
import 'widgets/school_text_field_widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    RegisterPageBloc registerPageBloc =
        BlocProvider.of<RegisterPageBloc>(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const BackgroundWidget(),
            GestureDetector(
              onTap: () {
                registerPageBloc.add(BackgroundTapEvent());
              },
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              ClipPath(
                                clipper: ProsteBezierCurve(
                                  position: ClipPosition.bottom,
                                  list: [
                                    BezierCurveSection(
                                      start: const Offset(0, 125),
                                      top: Offset(deviceWidth / 4, 145),
                                      end: Offset(deviceWidth / 2, 125),
                                    ),
                                    BezierCurveSection(
                                      start: Offset(deviceWidth / 2, 125),
                                      top: Offset(deviceWidth / 4 * 3, 100),
                                      end: Offset(deviceWidth, 120),
                                    ),
                                  ],
                                ),
                                child: Image.network(
                                  'https://i.pinimg.com/564x/bf/6f/70/bf6f70ce03bc014ea6b39b5724baf001.jpg',
                                  height: 150,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.bottomCenter,
                                ),
                              ),
                              Container(
                                height: 150,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            context
                                                .read<RegisterPageBloc>()
                                                .add(SignOutEvent(
                                                    navigatorToSignInPage: () {
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  RouteNames.kSignInPageRoute,
                                                  (route) => false);
                                            }));
                                          },
                                          child: const Icon(
                                            PhosphorIcons.x,
                                            color: ColorConstant.kOrangeColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const AvatarWidget(
                                      sizeMultiple: 1.2,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
                  const ContinueButtonWidget(),
                ],
              ),
            ),
            BlocBuilder<RegisterPageBloc, RegisterPageState>(
              builder: (context, state) {
                return Visibility(
                  visible: state.isWaitingRegister,
                  child: Stack(
                    children: [
                      const CustomBlurWidget(sigmaX: 3, sigmaY: 3),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(
                              color: ColorConstant.kOrangeColor,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Waiting for register...',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
