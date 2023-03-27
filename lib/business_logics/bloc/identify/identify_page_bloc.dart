import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_logics/bloc/identify/identify_page_event.dart';
import 'package:flutter_application_1/business_logics/bloc/identify/identify_page_state.dart';
import 'package:flutter_application_1/data/api_handling/identify_service.dart';
import 'package:flutter_application_1/data/models/detect_result_model/detect_result_model.dart';
import 'package:flutter_application_1/presentation/pages/identify_result_page/identify_result_page.dart';
import 'package:flutter_application_1/presentation/utilities/color_constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class IdentifyPageBLoc extends Bloc<IdentifyPageEvent, IdentifyPageState> {
  late final CameraController cameraController;
  final IdentifyService _identifyService = IdentifyService();
  BuildContext? context;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  late final String _jwt;

  IdentifyPageBLoc() : super(const IdentifyPageState()) {
    _storage.read(key: 'jwt').then((value) => _jwt = value ?? '');
    _cameraControllerInit();
    on<ShowModelEvent>(_onShowModelEvent);
    on<CameraControllerInitFinishEvent>(_onCameraControllerInitFinishEvent);
    on<TapGalleryButtonEvent>(_onTapGalleryButtonEvent);
    on<TapTakePictureButtonEvent>(_onTapTakePictureButtonEvent);
  }

  _onShowModelEvent(ShowModelEvent event, Emitter<IdentifyPageState> emit) {
    emit(IdentifyPageState(isShowModel: !state.isShowModel));
  }

  _onTapGalleryButtonEvent(
      TapGalleryButtonEvent event, Emitter<IdentifyPageState> emit) async {
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      CroppedFile? croppedFile = await _cropImage(xFile: xFile);
      if (croppedFile != null) {
        emit(state.copyWith(isLoading: true));
        DetectResultModel? detectResultModel =
            await _identifyService.identifyObject(
                evidencePath: croppedFile.path,
                apiPath: event.apiPath,
                jwt: _jwt);
        emit(state.copyWith(isLoading: false));
        Navigator.push(
          context!,
          MaterialPageRoute(
            builder: (context) => IdentifyResultPage(
              imagePath: croppedFile.path,
              detectResultModel: detectResultModel!,
            ),
          ),
        );
      }
    }
  }

  _onCameraControllerInitFinishEvent(
      CameraControllerInitFinishEvent event, Emitter<IdentifyPageState> emit) {
    emit(const IdentifyPageState(isCameraControllerInitFinish: true));
  }

  _onTapTakePictureButtonEvent(
      TapTakePictureButtonEvent event, Emitter<IdentifyPageState> emit) async {
    XFile xFile = await cameraController.takePicture();
    CroppedFile? croppedFile = await _cropImage(xFile: xFile);
    if (croppedFile != null) {
      emit(state.copyWith(isLoading: true));
      DetectResultModel? detectResultModel =
          await _identifyService.identifyObject(
              evidencePath: croppedFile.path,
              apiPath: event.apiPath,
              jwt: _jwt);
      emit(state.copyWith(isLoading: false));
      Navigator.push(
        context!,
        MaterialPageRoute(
          builder: (context) => IdentifyResultPage(
            imagePath: croppedFile.path,
            detectResultModel: detectResultModel!,
          ),
        ),
      );
    }
  }

  _cameraControllerInit() async {
    List<CameraDescription> cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.max);
    await cameraController.initialize();
    add(CameraControllerInitFinishEvent());
  }

  Future<CroppedFile?> _cropImage({required XFile xFile}) async {
    return await ImageCropper().cropImage(
      sourcePath: xFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: ColorConstant.kOrangeColor,
            toolbarWidgetColor: ColorConstant.kWhiteColor,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
      ],
    );
  }
}
