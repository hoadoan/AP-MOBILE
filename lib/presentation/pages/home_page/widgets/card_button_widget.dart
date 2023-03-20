import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/route_management/route_name.dart';
import 'package:flutter_application_1/presentation/utilities/assets_path_constant.dart';
import 'package:flutter_application_1/presentation/utilities/color_constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CardButtonWidget extends StatelessWidget {
  const CardButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardButtonItemWidget(
          name: 'Identify',
          subject: 'Tap to recognize objects',
          imagePath: IMAGE_PATH + SCAN_PNG,
          textColor: const Color.fromARGB(255, 246, 122, 78),
          subjectColor: const Color.fromARGB(255, 246, 122, 78),
          iconColor: const Color.fromARGB(255, 246, 122, 78),
          onTap: () {
            Navigator.pushNamed(context, RouteNames.kIdentifyPageRoute);
          },
          childAlign: CrossAxisAlignment.end,
        ),
        SizedBox(height: 20.h),
        CardButtonItemWidget(
          name: 'Training',
          subject: 'Tap to training AI model',
          imagePath: IMAGE_PATH + AI_TRAINING_JPG,
          svgPath: ICON_PATH + ARTIFICIAL_SVG,
          onTap: () {
            Navigator.pushNamed(context, RouteNames.kTrainingPageRoute);
          },
        ),
      ],
    );
  }
}

class CardButtonItemWidget extends StatelessWidget {
  const CardButtonItemWidget({
    super.key,
    required this.name,
    required this.subject,
    this.textColor = ColorConstant.kWhiteColor,
    this.subjectColor = ColorConstant.kWhiteColor,
    this.iconColor = ColorConstant.kWhiteColor,
    required this.imagePath,
    this.svgPath,
    required this.onTap,
    this.childAlign = CrossAxisAlignment.start,
    this.isAssetImage = true,
  });

  final String name;
  final String subject;
  final Color textColor;
  final Color subjectColor;
  final Color iconColor;
  final String imagePath;
  final String? svgPath;
  final Function() onTap;
  final bool isAssetImage;
  final CrossAxisAlignment childAlign;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: ColorConstant.kBlackColor.withOpacity(0.5),
                  offset: Offset(3.w, 5.w),
                  blurRadius: 10.w,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: isAssetImage
                  ? Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      width: 280.h,
                      height: 280.h,
                    )
                  : Image.network(
                      imagePath,
                      fit: BoxFit.cover,
                      width: 280.h,
                      height: 280.h,
                    ),
            ),
          ),
          Container(
            height: 280.h,
            width: 280.h,
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: childAlign,
              children: [
                if (svgPath != null)
                  SvgPicture.asset(
                    svgPath!,
                    width: 50.w,
                    color: iconColor,
                  ),
                const Spacer(),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    name,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 4.w,
                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    subject,
                    style: TextStyle(
                      color: subjectColor,
                      fontSize: 14.sp,
                      letterSpacing: 3.w,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
