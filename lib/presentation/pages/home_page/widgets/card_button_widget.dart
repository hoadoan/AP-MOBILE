import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/route_management/route_name.dart';
import 'package:flutter_application_1/presentation/utilities/assets_path_constant.dart';
import 'package:flutter_application_1/presentation/utilities/color_constant.dart';
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
          imagePath:
              'https://storage.ettip.com/Upload/Images/Vocabulary/Official/8514.png',
          svgPath: ICON_PATH + CAMERA_SVG,
          textColor: const Color.fromARGB(255, 246, 122, 78),
          subjectColor: const Color.fromARGB(255, 246, 122, 78),
          iconColor: const Color.fromARGB(255, 246, 122, 78),
          onTap: () {
            Navigator.pushNamed(context, RouteNames.kIdentifyPageRoute);
          },
          isAssetImage: false,
          childAlign: CrossAxisAlignment.end,
        ),
        const SizedBox(height: 20),
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
    required this.svgPath,
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
  final String svgPath;
  final Function() onTap;
  final bool isAssetImage;
  final CrossAxisAlignment childAlign;

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;

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
                  offset: const Offset(3, 5),
                  blurRadius: 10,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: isAssetImage
                  ? Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      width: deviceWidth - 60,
                      height: deviceWidth - 60,
                    )
                  : Image.network(
                      imagePath,
                      fit: BoxFit.cover,
                      width: deviceWidth - 60,
                      height: deviceWidth - 60,
                    ),
            ),
          ),
          Container(
            height: deviceWidth - 60,
            width: deviceWidth - 60,
            padding: const EdgeInsets.only(
              left: 16,
              top: 16,
              bottom: 16,
              right: 16,
            ),
            child: Column(
              crossAxisAlignment: childAlign,
              children: [
                SvgPicture.asset(
                  svgPath,
                  width: 50,
                  color: iconColor,
                ),
                const Spacer(),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    name,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 5,
                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    subject,
                    style: TextStyle(
                      color: subjectColor,
                      fontSize: 15,
                      letterSpacing: 4,
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
