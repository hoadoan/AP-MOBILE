import 'package:flutter/material.dart';

import '../utilities/assets_path_constant.dart';

class FPTLogoWidget extends StatelessWidget {
  const FPTLogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      margin: const EdgeInsets.only(top: 30, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color.fromARGB(255, 209, 230, 247),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            blurRadius: 10,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Image.asset(
        IMAGE_PATH + FPT_LOGO_PNG,
        width: 80,
        fit: BoxFit.cover,
      ),
    );
  }
}
