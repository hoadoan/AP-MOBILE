import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_logics/cubit/splash_page_cubit/splash_page_cubit.dart';
import 'package:flutter_application_1/presentation/custom_widgets/blur_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../custom_widgets/fpt_logo_widget.dart';
import '../../utilities/assets_path_constant.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SplashPageCubit splashPageCubit = context.watch<SplashPageCubit>();
    splashPageCubit.onReady(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onDoubleTap: () => splashPageCubit.onScreenTap(),
        child: Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: 50,
                left: 150,
                child: Image.asset(
                  IMAGE_PATH + SPLINE_PNG,
                ),
              ),
              const CustomBlurWidget(sigmaX: 20, sigmaY: 10),
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
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'version 0.0.1',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: const Color.fromARGB(255, 2, 29, 50),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
