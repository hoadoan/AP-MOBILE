import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

import '../../../utilities/color_constant.dart';
import '../../../utilities/right_angle_line_widget.dart';
import 'bottom_widget.dart';

class ForegroundWidget extends StatelessWidget {
  final String? apiPath;

  const ForegroundWidget({
    super.key,
    this.apiPath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {},
                child: const Icon(
                  PhosphorIcons.flashlight_fill,
                  color: ColorConstant.kTransparentColor,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  PhosphorIcons.x_bold,
                  color: ColorConstant.kWhiteColor,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    RightAngleWidget(type: RightAngleType.topLeft),
                    SizedBox(
                      height: 150,
                    ),
                    RightAngleWidget(type: RightAngleType.bottomLeft),
                  ],
                ),
                const SizedBox(
                  width: 150,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    RightAngleWidget(type: RightAngleType.topRight),
                    SizedBox(
                      height: 150,
                    ),
                    RightAngleWidget(type: RightAngleType.bottomRight),
                  ],
                ),
              ],
            ),
          ),
        ),
        BottomBarWidget(
          apiPath: apiPath,
        ),
      ],
    );
  }
}
