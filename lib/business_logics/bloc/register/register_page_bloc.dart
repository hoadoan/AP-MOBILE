import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_logics/bloc/register/register_page_event.dart';
import 'package:flutter_application_1/business_logics/bloc/register/register_page_state.dart';
import 'package:flutter_application_1/data/models/user_model/user_model.dart';
import 'package:flutter_application_1/presentation/route_management/route_name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../data/api_handling/user_service.dart';

class RegisterPageBloc extends Bloc<RegisterPageEvent, RegisterPageState> {
  final UserService _userService = UserService();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  final List<String> items = ['Alumnus', '12', '11', '10', '9', '8', '7', '6'];

  final TextEditingController phoneNumberTextEditingController =
      TextEditingController();
  final FocusNode phoneNumberFocusNode = FocusNode();

  final TextEditingController mailTextEditingController =
      TextEditingController();
  final FocusNode mailFocusNode = FocusNode();

  final TextEditingController nameTextEditingController =
      TextEditingController();
  final FocusNode nameFocusNode = FocusNode();

  final TextEditingController addressEditingController =
      TextEditingController();
  final FocusNode addressFocusNode = FocusNode();

  final TextEditingController schoolTextEditingController =
      TextEditingController();
  final FocusNode schoolFocusNode = FocusNode();

  final TextEditingController gradeTextEditingController =
      TextEditingController();
  final FocusNode gradeFocusNode = FocusNode();

  RegisterPageBloc(super.initialState) {
    mailTextEditingController.text = state.firebaseUser.email ?? '';
    nameTextEditingController.text = state.firebaseUser.displayName ?? '';

    on<FullNameValidationEvent>(_onFullNameValidationEvent);
    on<PhoneValidationEvent>(_onPhoneNumberValidationEvent);
    on<SchoolValidationEvent>(_onSchoolValidationEvent);
    on<GradeValidationEvent>(_onGradeValidationEvent);
    on<AddressValidationEvent>(_onAddressValidationEvent);
    on<BackgroundTapEvent>(_onBackgroundTapEvent);
    on<ContinueButtonEvent>(_onContinueButtonEvent);
    on<GradeChangeEvent>(_onGradeChangeEvent);
    on<SignOutEvent>(_onSignOutEvent);
  }

  _onSignOutEvent(SignOutEvent event, Emitter<RegisterPageState> emit) async {
    await FirebaseAuth.instance.signOut();
    event.navigatorToSignInPage();
  }

  _onFullNameValidationEvent(
      FullNameValidationEvent event, Emitter<RegisterPageState> emit) {
    String fullNameErrorMsg = '';
    if (nameTextEditingController.text.isEmpty) {
      fullNameErrorMsg = 'Full name field can\'t be empty';
    }
    emit(state.updateStateWith(fullNameErrorMsg: fullNameErrorMsg));
  }

  _onPhoneNumberValidationEvent(
      PhoneValidationEvent event, Emitter<RegisterPageState> emit) {}

  _onSchoolValidationEvent(
      SchoolValidationEvent event, Emitter<RegisterPageState> emit) {}

  _onGradeValidationEvent(
      GradeValidationEvent event, Emitter<RegisterPageState> emit) {}

  _onAddressValidationEvent(
      AddressValidationEvent event, Emitter<RegisterPageState> emit) {}

  _onContinueButtonEvent(
      ContinueButtonEvent event, Emitter<RegisterPageState> emit) async {
    if (state.fullNameErrorMsg.isEmpty) {
      emit(state.updateStateWith(isWaitingRegister: true));
      UserModel? userModel = await _userService.register(
        idToken: await state.firebaseUser.getIdToken(),
        name: nameTextEditingController.text,
        mail: mailTextEditingController.text,
        address: addressEditingController.text,
        grade: state.selectedGrade,
        phoneNumber: phoneNumberTextEditingController.text,
        school: schoolTextEditingController.text,
      );
      if (userModel != null) {
        await _storage.write(key: 'jwt', value: userModel.accessToken);

        Navigator.pushNamedAndRemoveUntil(
            event.buildContext, RouteNames.kHomePageRoute, (route) => false);
      }
    }
  }

  _onGradeChangeEvent(GradeChangeEvent event, Emitter<RegisterPageState> emit) {
    emit(state.updateStateWith(selectedGrade: event.grade));
  }

  _onBackgroundTapEvent(
      BackgroundTapEvent event, Emitter<RegisterPageState> emit) {
    phoneNumberFocusNode.unfocus();
    nameFocusNode.unfocus();
    schoolFocusNode.unfocus();
    gradeFocusNode.unfocus();
    addressFocusNode.unfocus();
  }
}
