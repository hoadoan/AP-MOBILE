import 'package:flutter/material.dart';

import 'color_constant.dart';

class RightAngleWidget extends StatelessWidget {
  final double size;
  final double width;
  final RightAngleType type;
  final Color lineColor;

  const RightAngleWidget({
    super.key,
    this.size = 60,
    this.width = 3,
    required this.type,
    this.lineColor = ColorConstant.kOrangeColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: type == RightAngleType.topLeft ||
                      type == RightAngleType.topRight
                  ? width
                  : 0,
              color: type == RightAngleType.topLeft ||
                      type == RightAngleType.topRight
                  ? lineColor
                  : ColorConstant.kTransparentColor,
            ),
            left: BorderSide(
              width: type == RightAngleType.topLeft ||
                      type == RightAngleType.bottomLeft
                  ? width
                  : 0,
              color: type == RightAngleType.topLeft ||
                      type == RightAngleType.bottomLeft
                  ? lineColor
                  : ColorConstant.kTransparentColor,
            ),
            right: BorderSide(
              width: type == RightAngleType.topRight ||
                      type == RightAngleType.bottomRight
                  ? width
                  : 0,
              color: type == RightAngleType.topRight ||
                      type == RightAngleType.bottomRight
                  ? lineColor
                  : ColorConstant.kTransparentColor,
            ),
            bottom: BorderSide(
              width: type == RightAngleType.bottomLeft ||
                      type == RightAngleType.bottomRight
                  ? width
                  : 0,
              color: type == RightAngleType.bottomLeft ||
                      type == RightAngleType.bottomRight
                  ? lineColor
                  : ColorConstant.kTransparentColor,
            ),
          ),
        ),
      ),
    );
  }
}

enum RightAngleType { topLeft, topRight, bottomLeft, bottomRight }
