import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/pages/home_page/widgets/card_button_widget.dart';
import 'package:flutter_application_1/presentation/pages/home_page/widgets/user_info_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rive/rive.dart';

import '../../custom_widgets/blur_widget.dart';
import '../../utilities/assets_path_constant.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 200.h,
              left: 120.w,
              child: Image.asset(
                IMAGE_PATH + SPLINE_PNG,
              ),
            ),
            Positioned(
              right: 0,
              bottom: 130,
              child: Image.asset(
                IMAGE_PATH + SPLINE_PNG,
                width: 840.w,
              ),
            ),
            const RiveAnimation.asset(
              RIVE_PATH + SHAPES_RIV,
              fit: BoxFit.cover,
            ),
            const CustomBlurWidget(sigmaX: 40, sigmaY: 40),
            SizedBox(
              height: deviceHeight,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const UserInfoWidget(),
                    SizedBox(height: 30.h),
                    const CardButtonWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
