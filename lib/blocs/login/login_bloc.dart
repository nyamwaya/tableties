import 'package:TableTies/blocs/login/login_button_pressed.dart';
import 'package:TableTies/blocs/login/login_event.dart';
import 'package:TableTies/blocs/login/login_state.dart';
import 'package:TableTies/dio_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final DioClient dioClient;

  LoginBloc({required this.dioClient}) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  void _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      final projectId = dotenv.env[dotenv.env['STYTCH_PROJECT_ID']];
      final secret = dotenv.env[dotenv.env['STYTCH_SECRET']];
      final credentials = base64Encode(utf8.encode('$projectId:$secret'));

      final response = await dioClient.dio.post(
        'https://api.stytch.com/v1/passwords/authenticate',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Basic $credentials',
          },
        ),
        data: {
          'email': event.email,
          'password': event.password,
        },
      );

      if (response.statusCode == 200) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure(error: 'Login failed'));
      }
    } catch (e) {
      print("Login Error ${e.toString()}");
      emit(LoginFailure(error: 'An error occurred'));
    }
  }
}
