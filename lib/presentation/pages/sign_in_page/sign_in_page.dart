import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_logics/bloc/sign_in/sign_in_page_bloc.dart';
import 'package:flutter_application_1/business_logics/bloc/sign_in/sign_in_page_event.dart';
import 'package:flutter_application_1/presentation/custom_widgets/gradient_widget.dart';
import 'package:flutter_application_1/presentation/pages/sign_in_page/widgets/sign_in_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';

import '../../custom_widgets/blur_widget.dart';
import '../../custom_widgets/fpt_logo_widget.dart';
import '../../utilities/assets_path_constant.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SignInPageBloc signInPageBloc = context.watch<SignInPageBloc>();

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 50.h,
            left: 150.w,
            child: Image.asset(
              IMAGE_PATH + SPLINE_PNG,
            ),
          ),
          const CustomBlurWidget(sigmaX: 20, sigmaY: 10),
          const RiveAnimation.asset(
            RIVE_PATH + SHAPES_RIV,
            fit: BoxFit.cover,
          ),
          const CustomBlurWidget(),
          Column(
            children: [
              Row(
                children: const [
                  Spacer(),
                  FPTLogoWidget(),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      IMAGE_PATH + AI_LOGO_PNG,
                      width: 70.w,
                      fit: BoxFit.cover,
                    ),
                    GradientWidget(
                      child: Text(
                        'F-detect',
                        style: GoogleFonts.righteous(
                          fontSize: 35.sp,
                          color: const Color.fromARGB(255, 2, 29, 50),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      'AI: Where Machines are Smarter',
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        color: const Color.fromARGB(255, 2, 29, 50),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SignInButtonWidget(
                      onTap: () {
                        signInPageBloc.add(SignInButtonEvent(context));
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: InkWell(
                  onTap: () {
                    signInPageBloc.add(SignOutButtonEvent());
                  },
                  child: Text(
                    'version 0.0.1',
                    style: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      color: const Color.fromARGB(255, 2, 29, 50),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
