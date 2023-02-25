import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPageState extends Equatable {
  final User firebaseUser;
  final String fullNameErrorMsg;
  final String? selectedGrade;
  final bool isWaitingRegister;

  const RegisterPageState({
    required this.firebaseUser,
    this.fullNameErrorMsg = '',
    this.selectedGrade,
    this.isWaitingRegister = false,
  });

  RegisterPageState updateStateWith({
    User? fireBaseUser,
    String? fullNameErrorMsg,
    String? selectedGrade,
    bool? isWaitingRegister,
  }) {
    return RegisterPageState(
      firebaseUser: fireBaseUser ?? firebaseUser,
      fullNameErrorMsg: fullNameErrorMsg ?? this.fullNameErrorMsg,
      selectedGrade: selectedGrade ?? this.selectedGrade,
      isWaitingRegister: isWaitingRegister ?? this.isWaitingRegister,
    );
  }

  @override
  List<Object?> get props => [
        firebaseUser,
        fullNameErrorMsg,
        selectedGrade,
        isWaitingRegister,
      ];
}
