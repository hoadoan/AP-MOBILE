abstract class TrainingPageEvent {}

class TapAddTrainingModelButtonEvent extends TrainingPageEvent {}

class AddTrainingModelEvent extends TrainingPageEvent {
  final String modelName;

  AddTrainingModelEvent({
    required this.modelName,
  });
}

class AddTrainingDataSetEvent extends TrainingPageEvent {
  final String modelName;

  AddTrainingDataSetEvent({
    required this.modelName,
  });
}

class RemoveTrainingDataSetEvent extends TrainingPageEvent {
  final String modelName;
  final int index;

  RemoveTrainingDataSetEvent({
    required this.modelName,
    required this.index,
  });
}

class RemoveTrainingModelEvent extends TrainingPageEvent {
  final String modelName;

  RemoveTrainingModelEvent({
    required this.modelName,
  });
}

class ChangeTrainingDataSetEvent extends TrainingPageEvent {
  final String modelName;
  final int index;

  ChangeTrainingDataSetEvent({
    required this.modelName,
    required this.index,
  });
}

class StartTrainingEvent extends TrainingPageEvent {
  StartTrainingEvent();
}
