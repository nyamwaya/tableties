import 'dart:convert';

import 'package:TableTies/blocs/login/login_button_pressed.dart';
import 'package:TableTies/blocs/login/login_event.dart';
import 'package:TableTies/blocs/login/login_state.dart';
import 'package:TableTies/models/login_response.dart';
import 'package:TableTies/repo/login_repo.dart';
import 'package:TableTies/services/preferences_service.dart';
import 'package:TableTies/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository repository;

  LoginBloc({required this.repository}) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  void _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    var data = await repository.login(event.email, event.password);
    print("user id is: ${data['user_id']}");

    //saveUserSession(data.)
    var serializedData = LoginResponse.fromJson(data);

    saveUserSession(serializedData.userId);

    emit(LoginSuccess(serializedData.toString()));
    try {} catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }
}
