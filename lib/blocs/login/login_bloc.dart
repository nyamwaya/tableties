
import 'package:TableTies/events/login_button_pressed.dart';
import 'package:TableTies/events/login_event.dart';
import 'package:TableTies/state/login_state.dart';
import 'package:TableTies/models/login_response.dart';
import 'package:TableTies/repo/login_repo.dart';
import 'package:TableTies/repo/supabase_repo.dart';
import 'package:TableTies/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository repository;

  LoginBloc(
      {required this.repository,
      required SupabaseRepository supabaseRepository})
      : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  void _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(LoginLoading());
      var data = await repository.login(event.email, event.password);

      var serializedData = LoginResponse.fromJson(data);

      // saving user id from the stytch
      // we could also make a request to supabase here but i think we should do it in the home bloc
      saveUserSession(serializedData.userId);
      emit(LoginSuccess(serializedData));

      print("User logged in successfully: ${data['user_id']}");
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
      print("Error logging in: $e");
    }
  }
}
