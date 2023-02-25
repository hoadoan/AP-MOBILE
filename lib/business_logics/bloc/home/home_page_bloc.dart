import 'package:flutter_application_1/business_logics/bloc/home/home_page_state.dart';
import 'package:flutter_application_1/data/api_handling/user_service.dart';
import 'package:flutter_application_1/data/models/user_model/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'home_page_event.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final UserService _userService = UserService();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  HomePageBloc() : super(const HomePageState()) {
    on<InitEvent>(_onInitEvent);

    add(InitEvent());
  }

  _onInitEvent(InitEvent event, Emitter<HomePageState> emit) async {
    emit(state.updateStateWith(isLoadData: true));
    String jwt = (await _storage.read(key: 'jwt'))!;
    UserModel? userModel = await _userService.fetchUserProfile(jwt: jwt);
    emit(state.updateStateWith(isLoadData: false, userModel: userModel));
  }
}
