import 'package:equatable/equatable.dart';

class TrainingPageState extends Equatable {
  final bool isShowTrainingModelList;
  final Map<String, List<String>> trainingModelMap;
  final int totalDataset;
  final bool stateControl;
  final bool isWaitingTraining;

  const TrainingPageState({
    this.isShowTrainingModelList = false,
    required this.trainingModelMap,
    this.totalDataset = 0,
    this.stateControl = false,
    this.isWaitingTraining = false,
  });

  TrainingPageState copyWith({
    bool? isShowTrainingModelList,
    Map<String, List<String>>? trainingModelMap,
    int? totalDataset,
    bool? stateControl,
    bool? isWaitingTraining,
  }) {
    return TrainingPageState(
      isShowTrainingModelList:
          isShowTrainingModelList ?? this.isShowTrainingModelList,
      trainingModelMap: trainingModelMap ?? this.trainingModelMap,
      totalDataset: totalDataset ?? this.totalDataset,
      stateControl: stateControl ?? this.stateControl,
      isWaitingTraining: isWaitingTraining ?? this.isWaitingTraining,
    );
  }

  @override
  List<Object?> get props => [
        trainingModelMap,
        isShowTrainingModelList,
        totalDataset,
        stateControl,
        isWaitingTraining,
      ];
}
