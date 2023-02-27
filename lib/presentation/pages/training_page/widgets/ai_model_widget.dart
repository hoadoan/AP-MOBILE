import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_logics/bloc/training/training_page_bloc.dart';
import 'package:flutter_application_1/business_logics/bloc/training/training_page_event.dart';
import 'package:flutter_application_1/business_logics/bloc/training/training_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utilities/assets_path_constant.dart';
import '../../../utilities/color_constant.dart';

class AIModelWidget extends StatelessWidget {
  const AIModelWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TrainingPageBloc trainingPageBloc =
        BlocProvider.of<TrainingPageBloc>(context);
    List<String> labelList = [
      'Dog',
      'Cat',
      'Fish',
      'Bird',
      'Pig',
      'Monkey',
    ];

    return Align(
      alignment: Alignment.centerRight,
      child: BlocBuilder<TrainingPageBloc, TrainingPageState>(
        builder: (context, state) {
          return state.isShowTrainingModelList
              ? AnimatedContainer(
                  curve: Curves.easeInOutCubicEmphasized,
                  duration: const Duration(
                    milliseconds: 500,
                  ),
                  width: 160,
                  height: 460,
                  padding: const EdgeInsets.only(top: 20, left: 16),
                  decoration: BoxDecoration(
                    color: ColorConstant.kOrangeColor.withOpacity(1),
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ColorConstant.kBlackColor.withOpacity(0.5),
                        offset: const Offset(-6, 6),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Column(
                      children: [
                        const Text(
                          'AI.Label',
                          style: TextStyle(
                            color: ColorConstant.kWhiteColor,
                            fontSize: 20,
                            letterSpacing: 2,
                          ),
                        ),
                        BlocBuilder<TrainingPageBloc, TrainingPageState>(
                          builder: (context, state) {
                            return Column(
                              children: [
                                ...List.generate(labelList.length, (index) {
                                  String modelImagePath = IMAGE_PATH;

                                  switch (labelList[index]) {
                                    case 'Dog':
                                      modelImagePath += DOG_PNG;
                                      break;
                                    case 'Cat':
                                      modelImagePath += CAT_ICON_PNG;
                                      break;
                                    default:
                                      modelImagePath += NO_AVATAR_PNG;
                                  }
                                  return state.trainingModelMap.keys
                                          .contains(labelList[index])
                                      ? InkWell(
                                          onTap: () {},
                                          child: Container(
                                            width: 145,
                                            margin: const EdgeInsets.symmetric(
                                              vertical: 8,
                                            ),
                                            padding: const EdgeInsets.only(
                                                left: 5, top: 5, bottom: 5),
                                            decoration: const BoxDecoration(
                                              color: ColorConstant.kWhiteColor,
                                              borderRadius:
                                                  BorderRadius.horizontal(
                                                left: Radius.circular(50),
                                              ),
                                            ),
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                top: 2,
                                                bottom: 2,
                                                left: 2,
                                              ),
                                              decoration: const BoxDecoration(
                                                color:
                                                    ColorConstant.kOrangeColor,
                                                borderRadius:
                                                    BorderRadius.horizontal(
                                                  left: Radius.circular(50),
                                                ),
                                              ),
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color:
                                                      ColorConstant.kWhiteColor,
                                                  borderRadius:
                                                      BorderRadius.horizontal(
                                                    left: Radius.circular(50),
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundImage:
                                                          AssetImage(
                                                        modelImagePath,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      labelList[index],
                                                      style: const TextStyle(
                                                        color: ColorConstant
                                                            .kOrangeColor,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            trainingPageBloc.add(
                                              AddTrainingModelEvent(
                                                modelName: labelList[index],
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: 145,
                                            margin: const EdgeInsets.symmetric(
                                              vertical: 8,
                                            ),
                                            padding: const EdgeInsets.only(
                                                left: 5, top: 5, bottom: 5),
                                            decoration: BoxDecoration(
                                              color: ColorConstant.kWhiteColor
                                                  .withOpacity(0.7),
                                              borderRadius:
                                                  const BorderRadius.horizontal(
                                                left: Radius.circular(50),
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  backgroundImage: AssetImage(
                                                    modelImagePath,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  labelList[index],
                                                  style: const TextStyle(
                                                    color: ColorConstant
                                                        .kOrangeColor,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                }),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                )
              : AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 100,
                  ),
                  width: 1,
                  height: 460,
                );
        },
      ),
    );
  }
}
