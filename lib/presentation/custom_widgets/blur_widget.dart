import 'dart:ui';

import 'package:flutter/material.dart';

class CustomBlurWidget extends StatelessWidget {
  final double sigmaX;
  final double sigmaY;
  final Widget? child;

  const CustomBlurWidget(
      {Key? key, this.sigmaX = 30, this.sigmaY = 30, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}
