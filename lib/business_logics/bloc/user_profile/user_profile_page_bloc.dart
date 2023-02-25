import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_logics/bloc/user_profile/user_profile_page_event.dart';
import 'package:flutter_application_1/business_logics/bloc/user_profile/user_profile_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../data/api_handling/user_service.dart';
import '../../../data/models/user_model/user_model.dart';

class UserProfilePageBloc
    extends Bloc<UserProfilePageEvent, UserProfilePageState> {
  final UserService _userService = UserService();
  UserModel? _userModel;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  late final String _jwt;

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

  UserProfilePageBloc(super.initialState) {
    on<FullNameValidationEvent>(_onFullNameValidationEvent);
    on<PhoneValidationEvent>(_onPhoneNumberValidationEvent);
    on<SchoolValidationEvent>(_onSchoolValidationEvent);
    on<GradeValidationEvent>(_onGradeValidationEvent);
    on<AddressValidationEvent>(_onAddressValidationEvent);
    on<BackgroundTapEvent>(_onBackgroundTapEvent);
    on<SaveButtonEvent>(_onContinueButtonEvent);
    on<GradeChangeEvent>(_onGradeChangeEvent);
    on<InitEvent>(_onInitEvent);
    on<SignOutEvent>(_onSignOutEvent);

    add(InitEvent());
  }

  _onSignOutEvent(
      SignOutEvent event, Emitter<UserProfilePageState> emit) async {
    emit(state.updateStateWith(isInit: true));
    await _storage.deleteAll();
    await FirebaseAuth.instance.signOut();
    event.navigatorToSignInPage();
  }

  _onInitEvent(InitEvent event, Emitter<UserProfilePageState> emit) async {
    _jwt = (await _storage.read(key: 'jwt'))!;
    _userModel = await _userService.fetchUserProfile(jwt: _jwt);
    String? grade;

    if (_userModel != null) {
      mailTextEditingController.text = _userModel!.email;
      nameTextEditingController.text = _userModel!.name;
      phoneNumberTextEditingController.text = _userModel!.phoneNumber ?? '';
      schoolTextEditingController.text = _userModel!.school ?? '';
      addressEditingController.text = _userModel!.address ?? '';
      if (_userModel!.grade!.isNotEmpty) {
        grade = _userModel!.grade;
      }
    }

    emit(state.updateStateWith(isInit: false, selectedGrade: grade));
  }

  _onFullNameValidationEvent(
      FullNameValidationEvent event, Emitter<UserProfilePageState> emit) {
    String fullNameErrorMsg = '';
    if (nameTextEditingController.text.isEmpty) {
      fullNameErrorMsg = 'Full name field can\'t be empty';
    }
    emit(
      state.updateStateWith(
        fullNameErrorMsg: fullNameErrorMsg,
        isChange: nameTextEditingController.text != _userModel?.name ||
            state.isChange,
      ),
    );
  }

  _onPhoneNumberValidationEvent(
      PhoneValidationEvent event, Emitter<UserProfilePageState> emit) {
    emit(
      state.updateStateWith(
        isChange:
            phoneNumberTextEditingController.text == _userModel?.phoneNumber ||
                state.isChange,
      ),
    );
  }

  _onSchoolValidationEvent(
      SchoolValidationEvent event, Emitter<UserProfilePageState> emit) {
    emit(
      state.updateStateWith(
        isChange: schoolTextEditingController.text != _userModel?.school ||
            state.isChange,
      ),
    );
  }

  _onGradeValidationEvent(
      GradeValidationEvent event, Emitter<UserProfilePageState> emit) {}

  _onAddressValidationEvent(
      AddressValidationEvent event, Emitter<UserProfilePageState> emit) {
    emit(
      state.updateStateWith(
        isChange: addressEditingController.text != _userModel?.address ||
            state.isChange,
      ),
    );
  }

  _onContinueButtonEvent(
      SaveButtonEvent event, Emitter<UserProfilePageState> emit) async {
    if (state.fullNameErrorMsg.isEmpty) {
      _unFocusAll();

      emit(state.updateStateWith(isWaitingUpdateProfile: true));

      UserModel? userModel = await _userService.updateProfile(
        jwt: _jwt,
        name: nameTextEditingController.text,
        mail: mailTextEditingController.text,
        address: addressEditingController.text,
        grade: state.selectedGrade,
        phoneNumber: phoneNumberTextEditingController.text,
        school: schoolTextEditingController.text,
      );
      if (userModel != null) {
        emit(
          state.updateStateWith(
            isWaitingUpdateProfile: false,
            isChange: false,
          ),
        );
        Fluttertoast.showToast(
            msg: 'Update use profile successfully!',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color.fromARGB(255, 17, 207, 144),
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        emit(state.updateStateWith(
          isWaitingUpdateProfile: false,
          isChange: true,
        ));
        Fluttertoast.showToast(
            msg: 'Update use profile failed!',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color.fromARGB(255, 207, 64, 17),
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  _onGradeChangeEvent(
      GradeChangeEvent event, Emitter<UserProfilePageState> emit) {
    emit(
      state.updateStateWith(
        selectedGrade: event.grade,
        isChange: event.grade != _userModel?.grade || state.isChange,
      ),
    );
  }

  _onBackgroundTapEvent(
      BackgroundTapEvent event, Emitter<UserProfilePageState> emit) {
    _unFocusAll();
  }

  _unFocusAll() {
    phoneNumberFocusNode.unfocus();
    nameFocusNode.unfocus();
    schoolFocusNode.unfocus();
    gradeFocusNode.unfocus();
    addressFocusNode.unfocus();
  }
}
