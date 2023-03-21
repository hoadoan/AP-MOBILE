import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/api_handling/room_service.dart';
import 'package:flutter_application_1/presentation/route_management/route_name.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:rive/rive.dart';

import '../../custom_widgets/blur_widget.dart';
import '../../utilities/assets_path_constant.dart';
import '../../utilities/color_constant.dart';

class RoomListView extends StatelessWidget {
  const RoomListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
          SafeArea(
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
                      'Training Room',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(
                        PhosphorIcons.trash,
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
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: FutureBuilder(
                    future: RoomService.instance.fetchListRoom(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SingleChildScrollView(
                          child: Column(
                            children: snapshot.data!
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            RouteNames.kTrainingPageRoute);
                                      },
                                      child: DottedBorder(
                                        radius: const Radius.circular(10),
                                        borderType: BorderType.RRect,
                                        color: ColorConstant.kOrangeColor,
                                        borderPadding: EdgeInsets.zero,
                                        dashPattern: const [5, 3],
                                        child: Container(
                                          // width: deviceWidth * 0.6,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                            vertical: 5,
                                          ),
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 2,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: ColorConstant.kOrangeColor,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Join training room <${e.name}>',
                                                style: const TextStyle(
                                                  color:
                                                      ColorConstant.kWhiteColor,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              const Icon(
                                                PhosphorIcons
                                                    .caret_double_right,
                                                size: 18,
                                                color:
                                                    ColorConstant.kWhiteColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
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
