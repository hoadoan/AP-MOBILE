import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/data/models/user_model/user_model.dart';

class UserProfilePageState extends Equatable {
  final String fullNameErrorMsg;
  final String? selectedGrade;
  final bool isWaitingUpdateProfile;
  final bool isChange;
  final bool isInit;

  const UserProfilePageState({
    this.fullNameErrorMsg = '',
    this.selectedGrade,
    this.isWaitingUpdateProfile = false,
    this.isChange = false,
    this.isInit = true,
  });

  UserProfilePageState updateStateWith({
    UserModel? userModel,
    String? fullNameErrorMsg,
    String? selectedGrade,
    bool? isWaitingUpdateProfile,
    bool? isChange,
    bool? isInit,
  }) {
    return UserProfilePageState(
      fullNameErrorMsg: fullNameErrorMsg ?? this.fullNameErrorMsg,
      selectedGrade: selectedGrade ?? this.selectedGrade,
      isWaitingUpdateProfile:
          isWaitingUpdateProfile ?? this.isWaitingUpdateProfile,
      isChange: isChange ?? this.isChange,
      isInit: isInit ?? this.isInit,
    );
  }

  @override
  List<Object?> get props => [
        fullNameErrorMsg,
        selectedGrade,
        isWaitingUpdateProfile,
        isChange,
        isInit,
      ];
}
