import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/utilities/assets_path_constant.dart';
import 'package:flutter_application_1/presentation/utilities/color_constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 40),
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
                  modelImagePath += No_AVATAR_PNG;
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
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Image.asset(
                                modelImagePath,
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                            ),
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
                        context.read<TrainingPageBloc>().add(
                              AddTrainingDataSetEvent(
                                modelName: state.trainingModelMap.keys
                                    .elementAt(index),
                              ),
                            );
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
