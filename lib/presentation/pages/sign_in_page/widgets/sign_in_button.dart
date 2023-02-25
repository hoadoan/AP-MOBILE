import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utilities/assets_path_constant.dart';

class SignInButtonWidget extends StatelessWidget {
  const SignInButtonWidget({super.key, required this.onTap});

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 32,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: const Color.fromARGB(255, 209, 230, 247),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              blurRadius: 8,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ICON_PATH + GOOGLE_LOGO_SVG,
              width: 30,
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              'Sign in with Google',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: const Color.fromARGB(255, 2, 29, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
