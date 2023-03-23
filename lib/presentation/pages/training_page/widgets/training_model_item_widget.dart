import 'dart:io';

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/utilities/assets_path_constant.dart';
import 'package:flutter_application_1/presentation/utilities/color_constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../business_logics/bloc/training/training_page_bloc.dart';
import '../../../../business_logics/bloc/training/training_page_event.dart';
import '../../../../business_logics/bloc/training/training_page_state.dart';

class TrainingModelItem extends StatelessWidget {
  const TrainingModelItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final TrainingPageBloc trainingPageBloc =
        BlocProvider.of<TrainingPageBloc>(context);

    return BlocBuilder<TrainingPageBloc, TrainingPageState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 40,
              vertical: state.trainingModelMap.keys.isNotEmpty ? 20 : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                List.generate(state.trainingModelMap.keys.length, (index) {
              String modelName = state.trainingModelMap.keys.elementAt(index);
              String modelImagePath = IMAGE_PATH;
              switch (modelName) {
                case 'Dog':
                  modelImagePath += DOG_PNG;
                  break;
                case 'Cat':
                  modelImagePath += CAT_ICON_PNG;
                  break;
                default:
                  modelImagePath += NO_AVATAR_PNG;
              }
              List<String> imageFilePaths = state.trainingModelMap[modelName]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {},
                    child: DottedBorder(
                      radius: const Radius.circular(10),
                      borderType: BorderType.RRect,
                      color: ColorConstant.kOrangeColor,
                      strokeCap: StrokeCap.square,
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorConstant.kOrangeColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        width: deviceWidth * 0.55,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 2,
                          vertical: 2,
                        ),
                        child: Row(
                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.all(5),
                            //   child: Image.asset(
                            //     modelImagePath,
                            //     width: 30,
                            //     height: 30,
                            //     fit: BoxFit.cover,
                            //   ),
                            // ),
                            const SizedBox(
                              width: 8,
                            ),
                            FittedBox(
                              alignment: Alignment.centerLeft,
                              fit: BoxFit.scaleDown,
                              child: Text(
                                '$modelName label',
                                style: const TextStyle(
                                  color: ColorConstant.kWhiteColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                trainingPageBloc.add(RemoveTrainingModelEvent(
                                    modelName: modelName));
                              },
                              child: Container(
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 247, 121, 79),
                                  borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(10)),
                                ),
                                child: const Icon(
                                  PhosphorIcons.x,
                                  color: ColorConstant.kWhiteColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ...List.generate(imageFilePaths.length, (childIndex) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DottedBorder(
                            padding: EdgeInsets.zero,
                            color: ColorConstant.kOrangeColor,
                            strokeWidth: 1,
                            borderPadding: EdgeInsets.zero,
                            dashPattern: const [3, 5],
                            child: const SizedBox(
                              height: 10,
                              width: 0,
                            ),
                          ),
                          Row(
                            children: [
                              DottedBorder(
                                padding: EdgeInsets.zero,
                                strokeWidth: 1,
                                color: ColorConstant.kOrangeColor,
                                borderPadding: EdgeInsets.zero,
                                dashPattern: const [3, 5],
                                child: const SizedBox(
                                  height: 80,
                                  width: 0,
                                ),
                              ),
                              DottedBorder(
                                padding: EdgeInsets.zero,
                                strokeWidth: 1,
                                strokeCap: StrokeCap.butt,
                                borderPadding: EdgeInsets.zero,
                                dashPattern: const [3, 5],
                                color: ColorConstant.kOrangeColor,
                                child: const SizedBox(
                                  height: 0,
                                  width: 40,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: ColorConstant.kOrangeColor,
                                  ),
                                  color: ColorConstant.kOrangeColor
                                      .withOpacity(0.05),
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        height: 65,
                                        width: 65,
                                        fit: BoxFit.cover,
                                        File(
                                          imageFilePaths.elementAt(childIndex),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    SizedBox(
                                      height: 65,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              trainingPageBloc.add(
                                                ChangeTrainingDataSetEvent(
                                                  modelName: modelName,
                                                  index: childIndex,
                                                ),
                                              );
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 47, 210, 182),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: const Icon(
                                                PhosphorIcons.crop,
                                                size: 18,
                                                color:
                                                    ColorConstant.kWhiteColor,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              trainingPageBloc.add(
                                                RemoveTrainingDataSetEvent(
                                                  modelName: modelName,
                                                  index: childIndex,
                                                ),
                                              );
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 247, 121, 79),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: const Icon(
                                                PhosphorIcons.x,
                                                size: 18,
                                                color:
                                                    ColorConstant.kWhiteColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: DottedBorder(
                      padding: EdgeInsets.zero,
                      strokeWidth: 1,
                      color: ColorConstant.kOrangeColor,
                      borderPadding: EdgeInsets.zero,
                      dashPattern: const [3, 5],
                      child: const SizedBox(
                        height: 20,
                        width: 0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: InkWell(
                      onTap: () {
                        getImageSource(context).then(
                            (value) => context.read<TrainingPageBloc>().add(
                                  AddTrainingDataSetEvent(
                                      modelName: state.trainingModelMap.keys
                                          .elementAt(index),
                                      imageSource: value),
                                ));
                      },
                      child: DottedBorder(
                        radius: const Radius.circular(10),
                        borderType: BorderType.RRect,
                        color: ColorConstant.kOrangeColor,
                        borderPadding: EdgeInsets.zero,
                        dashPattern: const [5, 3],
                        child: Container(
                          width: deviceWidth * 0.5 - 12,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 2,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: ColorConstant.kOrangeColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: const [
                              Text(
                                'Add training dataset',
                                style: TextStyle(
                                  color: ColorConstant.kOrangeColor,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                PhosphorIcons.plus_circle,
                                size: 18,
                                color: ColorConstant.kOrangeColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              );
            }),
          ),
        );
      },
    );
  }
}

Future<ImageSource> getImageSource(BuildContext context) async {
  late final ImageSource imageSource;
  await showFlexibleBottomSheet(
    minHeight: 0,
    initHeight: 0.17,
    maxHeight: 1,
    context: context,
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    bottomSheetColor: Colors.transparent,
    builder: (context, scrollController, bottomSheetOffset) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Column(
          children: [
            Container(
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BottomSheetButtonWidget(
              iconData: CupertinoIcons.photo_on_rectangle,
              onTap: () {
                imageSource = ImageSource.gallery;
                Navigator.of(context).pop();
              },
              title: 'Chọn ảnh từ thư viện',
            ),
            const SizedBox(
              height: 10,
            ),
            BottomSheetButtonWidget(
              iconData: CupertinoIcons.camera,
              onTap: () {
                imageSource = ImageSource.camera;
                Navigator.of(context).pop();
              },
              title: 'Chụp ảnh mới',
            ),
          ],
        ),
      );
    },
    anchors: [0, 0.5, 1],
    isSafeArea: true,
  );

  return imageSource;
}

class BottomSheetButtonWidget extends StatelessWidget {
  final IconData iconData;
  final Function() onTap;
  final String title;

  const BottomSheetButtonWidget(
      {super.key,
      required this.iconData,
      required this.onTap,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.black.withOpacity(0.1),
            child: Icon(
              iconData,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
