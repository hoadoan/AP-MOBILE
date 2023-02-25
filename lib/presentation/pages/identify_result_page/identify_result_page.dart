import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/route_management/route_name.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

import 'package:flutter_application_1/presentation/utilities/color_constant.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:rive/rive.dart';
import 'package:share_plus/share_plus.dart';

import '../../custom_widgets/blur_widget.dart';
import '../../utilities/assets_path_constant.dart';

class IdentifyResultPage extends StatelessWidget {
  final String imagePath;
  final Uint8List bytesResult;

  const IdentifyResultPage({
    Key? key,
    required this.imagePath,
    required this.bytesResult,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      PhosphorIcons.arrow_left_bold,
                    ),
                  ),
                ),
                const Text(
                  'Identify Result',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(
                    PhosphorIcons.arrow_left_bold,
                    color: ColorConstant.kTransparentColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 0.7,
              color: ColorConstant.kBlackColor.withOpacity(0.3),
            ),
            Expanded(
              child: Stack(
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
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              RouteNames.kCustomPhotoViewPageRoute,
                              arguments: bytesResult);
                        },
                        child: Hero(
                          tag: 'photo_view',
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorConstant.kBlackColor
                                      .withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(8, 8),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.memory(
                                bytesResult,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  height: 1,
                  color: ColorConstant.kBlackColor.withOpacity(0.5),
                ),
                Container(
                  alignment: Alignment.center,
                  color: const Color.fromARGB(255, 255, 246, 229),
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const CircleAvatar(
                          radius: 21,
                          backgroundColor: Color.fromARGB(255, 11, 172, 129),
                          child: Icon(
                            PhosphorIcons.camera_fill,
                            color: ColorConstant.kWhiteColor,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Share.shareXFiles(
                            [
                              XFile(imagePath),
                            ],
                          );
                        },
                        child: const CircleAvatar(
                          radius: 21,
                          backgroundColor: Color.fromARGB(255, 254, 229, 207),
                          child: Icon(
                            PhosphorIcons.share,
                            color: Color.fromARGB(255, 174, 105, 3),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await ImageGallerySaver.saveFile(imagePath);
                          Fluttertoast.showToast(
                              msg: 'Save image to gallery successfully!',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor:
                                  const Color.fromARGB(255, 17, 207, 144),
                              textColor: Colors.white,
                              fontSize: 16.0);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 30),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 161, 79),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: ColorConstant.kOrangeColor,
                                width: 1.5,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(255, 251, 170, 95),
                                  blurRadius: 8,
                                  offset: Offset(3, 3),
                                )
                              ]),
                          child: const Text(
                            'Save Result Image',
                            style: TextStyle(
                              color: ColorConstant.kWhiteColor,
                              fontSize: 16,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
