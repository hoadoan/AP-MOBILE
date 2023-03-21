import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_logics/bloc/training/training_page_bloc.dart';
import 'package:flutter_application_1/business_logics/bloc/training/training_page_state.dart';
import 'package:flutter_application_1/presentation/custom_widgets/gradient_widget.dart';
import 'package:flutter_application_1/presentation/pages/training_page/widgets/training_model_item_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:rive/rive.dart' as rive;

import '../../../business_logics/bloc/training/training_page_event.dart';
import '../../custom_widgets/blur_widget.dart';
import '../../utilities/assets_path_constant.dart';
import '../../utilities/color_constant.dart';
import 'widgets/ai_model_widget.dart';

class TrainingPage extends StatelessWidget {
  const TrainingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TrainingPageBloc trainingPageBloc =
        BlocProvider.of<TrainingPageBloc>(context);
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
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
            const rive.RiveAnimation.asset(
              RIVE_PATH + SHAPES_RIV,
              fit: BoxFit.cover,
            ),
            Container(
              color: ColorConstant.kWhiteColor.withOpacity(0.85),
            ),
            const CustomBlurWidget(sigmaX: 40, sigmaY: 40),
            Column(
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
                      'Training A.I Label',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(
                        PhosphorIcons.trash,
                        color: ColorConstant.kRedColor,
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
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        BlocBuilder<TrainingPageBloc, TrainingPageState>(
                          builder: (context, state) {
                            return Visibility(
                              visible: state.trainingModelMap.isEmpty,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 40),
                                child: Column(
                                  children: [
                                    Image.asset(IMAGE_PATH + AI_LOGO_PNG),
                                    Text(
                                      true
                                          ? 'A.I label have been training by 99 dataset\nAdd your dataset to help A.I better...'
                                          : 'Identify A.I label is new\nAdd your dataset for training...',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: ColorConstant.kBlackColor
                                              .withOpacity(0.7)),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: TrainingModelItem(),
                        ),
                        InkWell(
                          onTap: () {
                            trainingPageBloc
                                .add(TapAddTrainingModelButtonEvent());
                          },
                          child: DottedBorder(
                            radius: const Radius.circular(10),
                            borderType: BorderType.RRect,
                            color: ColorConstant.kOrangeColor,
                            borderPadding: EdgeInsets.zero,
                            dashPattern: const [5, 3],
                            child: Container(
                              width: deviceWidth * 0.6,
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
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Add training label',
                                    style: TextStyle(
                                      color: ColorConstant.kWhiteColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    PhosphorIcons.plus_circle,
                                    size: 18,
                                    color: ColorConstant.kWhiteColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 0.7,
                  color: ColorConstant.kBlackColor.withOpacity(0.3),
                ),
                Stack(
                  children: [
                    Center(
                      child: GradientWidget(
                        child: InkWell(
                          onTap: () {
                            trainingPageBloc.add(StartTrainingEvent());
                          },
                          child: Container(
                            width: deviceWidth * 0.9,
                            height: 40,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                color: ColorConstant.kWhiteColor,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 60,
                      child: InkWell(
                        onTap: () {
                          trainingPageBloc.add(StartTrainingEvent());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Send Training Dataset To Mentor',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: ColorConstant.kWhiteColor,
                                letterSpacing: 1.2,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              PhosphorIcons.traffic_sign,
                              color: ColorConstant.kWhiteColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Center(
                      child: GradientWidget(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 210, 69, 3),
                            Color.fromARGB(255, 255, 233, 32),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            trainingPageBloc.add(StartTrainingEvent());
                          },
                          child: Container(
                            width: deviceWidth * 0.9,
                            height: 40,
                            margin: const EdgeInsets.symmetric(vertical: 0),
                            decoration: BoxDecoration(
                                color: ColorConstant.kWhiteColor,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 40,
                      color: Colors.black.withOpacity(0),
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Detect Object Using This Room A.I',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: ColorConstant.kWhiteColor,
                                letterSpacing: 1.2,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              PhosphorIcons.train,
                              color: ColorConstant.kWhiteColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const AIModelWidget(),
            BlocBuilder<TrainingPageBloc, TrainingPageState>(
              builder: (context, state) {
                return Visibility(
                  visible: state.isWaitingTraining,
                  child: Stack(
                    children: [
                      const CustomBlurWidget(sigmaX: 3, sigmaY: 3),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Waiting for training...',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
