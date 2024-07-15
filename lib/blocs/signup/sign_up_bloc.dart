import 'package:TableTies/repo/sign_up_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpRepository repository;

  SignUpBloc({required this.repository}) : super(SignUpInitial()) {
    on<SignUpSubmitted>(_onSignUpSubmitted);
  }

  void _onSignUpSubmitted(
    SignUpSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoading());
    try {
      var data =
          await repository.signUp(event.fullName, event.email, event.password);
      emit(SignUpSuccess(data));
    } catch (e) {
      print("sign");
      emit(SignUpFailure(e.toString()));
    }
  }
}
