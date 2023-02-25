import 'package:flutter/material.dart';

class GradientWidget extends StatelessWidget {
  final Widget child;
  final Gradient gradient;

  const GradientWidget({
    Key? key,
    required this.child,
    this.gradient = const LinearGradient(
      colors: [
        Color.fromARGB(255, 82, 3, 210),
        Color.fromARGB(255, 1, 226, 226),
      ],
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: child,
    );
  }
}
