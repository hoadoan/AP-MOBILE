import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../utilities/assets_path_constant.dart';
import '../utilities/color_constant.dart';
import 'blur_widget.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 200,
          left: 120,
          child: Image.asset(
            IMAGE_PATH + SPLINE_PNG,
          ),
        ),
        Positioned(
          right: 0,
          bottom: 130,
          child: Image.asset(
            IMAGE_PATH + SPLINE_PNG,
            width: 900,
          ),
        ),
        const RiveAnimation.asset(
          RIVE_PATH + SHAPES_RIV,
          fit: BoxFit.cover,
        ),
        Container(
          color: ColorConstant.kWhiteColor.withOpacity(0.85),
        ),
        const CustomBlurWidget(sigmaX: 40, sigmaY: 40),
      ],
    );
  }
}
