import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class IdentifyPageState extends Equatable {
  final bool isShowModel;
  final bool isCameraControllerInitFinish;
  final XFile? xFile;
  final bool isLoading;

  const IdentifyPageState({
    this.isShowModel = false,
    this.isCameraControllerInitFinish = false,
    this.xFile,
    this.isLoading = false,
  });

  IdentifyPageState copyWith({
    bool? isShowModel,
    bool? isCameraControllerInitFinish,
    XFile? xFile,
    bool? isLoading,
  }) {
    return IdentifyPageState(
      isShowModel: isShowModel ?? this.isShowModel,
      isCameraControllerInitFinish:
          isCameraControllerInitFinish ?? this.isCameraControllerInitFinish,
      xFile: xFile ?? this.xFile,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        isShowModel,
        isCameraControllerInitFinish,
        isLoading,
      ];
}
