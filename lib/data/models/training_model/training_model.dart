import 'package:equatable/equatable.dart';

class TrainingModel extends Equatable {
  final List<String> dataSetPaths;

  const TrainingModel({
    required this.dataSetPaths,
  });

  @override
  List<Object?> get props => [];
}
