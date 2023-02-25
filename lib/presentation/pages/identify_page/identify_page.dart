import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_logics/bloc/identify/identify_page_bloc.dart';
import 'package:flutter_application_1/business_logics/bloc/identify/identify_page_state.dart';
import 'package:flutter_application_1/presentation/pages/identify_page/widgets/foreground_widget.dart';
import 'package:flutter_application_1/presentation/utilities/color_constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../custom_widgets/blur_widget.dart';

class IdentifyPage extends StatelessWidget {
  const IdentifyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IdentifyPageBLoc identifyPageBLoc =
        BlocProvider.of<IdentifyPageBLoc>(context);
    identifyPageBLoc.context = context;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            BlocBuilder<IdentifyPageBLoc, IdentifyPageState>(
              builder: (context, state) {
                return state.isCameraControllerInitFinish
                    ? SizedBox.expand(
                        child: CameraPreview(
                          identifyPageBLoc.cameraController,
                        ),
                      )
                    : const SizedBox.shrink();
              },
            ),
            const ForegroundWidget(),
            BlocBuilder<IdentifyPageBLoc, IdentifyPageState>(
              builder: (context, state) {
                return Visibility(
                  visible: state.isLoading,
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
                              'Waiting for identify object...',
                              style: TextStyle(
                                color: ColorConstant.kWhiteColor,
                              ),
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
