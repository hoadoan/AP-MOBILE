import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/data/models/user_model/user_model.dart';

class HomePageState extends Equatable {
  final bool isLoadData;
  final UserModel? userModel;

  const HomePageState({
    this.isLoadData = false,
    this.userModel,
  });

  HomePageState updateStateWith({
    bool? isLoadData,
    UserModel? userModel,
  }) {
    return HomePageState(
      isLoadData: isLoadData ?? this.isLoadData,
      userModel: userModel ?? this.userModel,
    );
  }

  @override
  List<Object?> get props => [
        isLoadData,
      ];
}
