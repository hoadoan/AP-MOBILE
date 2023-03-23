import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_logics/bloc/training/training_page_event.dart';
import 'package:flutter_application_1/business_logics/bloc/training/training_page_state.dart';
import 'package:flutter_application_1/data/api_handling/traning_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../presentation/utilities/color_constant.dart';

class TrainingPageBloc extends Bloc<TrainingPageEvent, TrainingPageState> {
  final TrainingService _trainingService = TrainingService();

  TrainingPageBloc()
      : super(const TrainingPageState(
            trainingModelMap: <String, List<String>>{})) {
    on<TapAddTrainingModelButtonEvent>(_onTapAddTrainingModelButtonEvent);
    on<AddTrainingModelEvent>(_onAddTrainingModelEvent);
    on<AddTrainingDataSetEvent>(_onAddTrainingDataSetEvent);
    on<RemoveTrainingDataSetEvent>(_onRemoveTrainingDataSetEvent);
    on<ChangeTrainingDataSetEvent>(_onChangeTrainingDataSetEvent);
    on<StartTrainingEvent>(_onStartTrainingEvent);
    on<RemoveTrainingModelEvent>(_onRemoveTrainingModelEvent);
    on<RemoveAllEvent>(_onRemoveAllEvent);
  }

  _onTapAddTrainingModelButtonEvent(
      TapAddTrainingModelButtonEvent event, Emitter<TrainingPageState> emit) {
    emit(state.copyWith(
        isShowTrainingModelList: !state.isShowTrainingModelList));
  }

  _onAddTrainingDataSetEvent(
      AddTrainingDataSetEvent event, Emitter<TrainingPageState> emit) async {
    int totalDataset = state.totalDataset;
    List<XFile> imagesFile = [];
    if (event.imageSource == ImageSource.gallery) {
      imagesFile = await ImagePicker().pickMultiImage();
    } else {
      XFile? xFile = await ImagePicker().pickImage(source: event.imageSource);
      if (xFile != null) {
        imagesFile.add(xFile);
      }
    }

    if (imagesFile.isNotEmpty) {
      List<String> imagePaths = state.trainingModelMap[event.modelName]!;
      for (var element in imagesFile) {
        if (!imagePaths.contains(element.path)) {
          imagePaths.add(element.path);
          totalDataset++;
        }
      }

      final Map<String, List<String>> trainingModelMap =
          Map.from(state.trainingModelMap);

      trainingModelMap[event.modelName] = imagePaths;

      emit(
        state.copyWith(
          trainingModelMap: trainingModelMap,
          totalDataset: totalDataset,
        ),
      );
    }
  }

  _onRemoveTrainingDataSetEvent(
      RemoveTrainingDataSetEvent event, Emitter<TrainingPageState> emit) async {
    int totalDataset = state.totalDataset;
    List<String> imagePaths = state.trainingModelMap[event.modelName]!;
    imagePaths.removeAt(event.index);
    totalDataset--;

    final Map<String, List<String>> trainingModelMap =
        Map.from(state.trainingModelMap);

    trainingModelMap[event.modelName] = imagePaths;

    emit(
      state.copyWith(
        trainingModelMap: trainingModelMap,
        totalDataset: totalDataset,
      ),
    );
  }

  _onRemoveTrainingModelEvent(
      RemoveTrainingModelEvent event, Emitter<TrainingPageState> emit) async {
    int totalDataset = state.totalDataset;
    totalDataset -= state.trainingModelMap[event.modelName]!.length;

    final Map<String, List<String>> trainingModelMap =
        Map.from(state.trainingModelMap);

    trainingModelMap.remove(event.modelName);

    emit(
      state.copyWith(
        trainingModelMap: trainingModelMap,
        totalDataset: totalDataset,
      ),
    );
  }

  _onRemoveAllEvent(
      RemoveAllEvent event, Emitter<TrainingPageState> emit) async {
    emit(
      state.copyWith(
        trainingModelMap: {},
        totalDataset: 0,
      ),
    );
  }

  _onAddTrainingModelEvent(
      AddTrainingModelEvent event, Emitter<TrainingPageState> emit) {
    final Map<String, List<String>> trainingModelMap =
        Map.from(state.trainingModelMap);

    trainingModelMap[event.modelName] = [];

    emit(
      state.copyWith(
        isShowTrainingModelList: false,
        trainingModelMap: trainingModelMap,
      ),
    );
  }

  _onChangeTrainingDataSetEvent(
      ChangeTrainingDataSetEvent event, Emitter<TrainingPageState> emit) async {
    List<String> imagePaths = state.trainingModelMap[event.modelName]!;

    CroppedFile? croppedFile =
        await _cropImage(path: imagePaths.elementAt(event.index));
    if (croppedFile != null) {
      imagePaths[event.index] = croppedFile.path;

      final Map<String, List<String>> trainingModelMap =
          Map.from(state.trainingModelMap);

      trainingModelMap[event.modelName] = imagePaths;

      emit(
        state.copyWith(
          trainingModelMap: trainingModelMap,
          stateControl: !state.stateControl,
        ),
      );
    }
  }

  _onStartTrainingEvent(
      StartTrainingEvent event, Emitter<TrainingPageState> emit) async {
    emit(state.copyWith(isWaitingTraining: true));
    await _trainingService.training(
        trainingModelMap: state.trainingModelMap, id: event.id);
    emit(state.copyWith(
        isWaitingTraining: false, totalDataset: 0, trainingModelMap: {}));

    Fluttertoast.showToast(
        msg: 'Training for A.I label successfully!',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 17, 207, 144),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<CroppedFile?> _cropImage({required String path}) async {
    return await ImageCropper().cropImage(
      sourcePath: path,
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
