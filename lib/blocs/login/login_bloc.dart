import 'package:TableTies/blocs/login/login_button_pressed.dart';
import 'package:TableTies/blocs/login/login_event.dart';
import 'package:TableTies/blocs/login/login_state.dart';
import 'package:TableTies/repo/login_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    emit(LoginSuccess(data));
    try {} catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }
}
