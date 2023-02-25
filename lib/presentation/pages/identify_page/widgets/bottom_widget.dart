import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_logics/bloc/identify/identify_page_bloc.dart';
import 'package:flutter_application_1/business_logics/bloc/identify/identify_page_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utilities/assets_path_constant.dart';
import '../../../utilities/color_constant.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    IdentifyPageBLoc identifyPageBLoc = context.read<IdentifyPageBLoc>();
    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: ColorConstant.kOrangeColor.withOpacity(0.8),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 60,
            padding: const EdgeInsets.only(top: 20),
            child: InkWell(
              onTap: () {
                identifyPageBLoc.add(TapGalleryButtonEvent());
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    IMAGE_PATH + GALLERY_PNG,
                    fit: BoxFit.cover,
                    width: 40,
                    height: 40,
                  ),
                  Text(
                    'Gallery',
                    style: GoogleFonts.dancingScript(
                      color: ColorConstant.kWhiteColor,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              identifyPageBLoc.add(TapTakePictureButtonEvent());
            },
            child: Container(
              height: 65,
              width: 65,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  width: 4,
                  color: ColorConstant.kWhiteColor,
                ),
              ),
              child: const CircleAvatar(
                radius: 26,
                backgroundColor: ColorConstant.kWhiteColor,
              ),
            ),
          ),
          Container(
            width: 60,
          ),
        ],
      ),
    );
  }
}
