import 'package:TableTies/resource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:TableTies/repo/sign_up_repo.dart';
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
    final Resource<String> result = await repository.signUp(
      event.fullName,
      event.email,
      event.password,
    );

    switch (result.status) {
      case ResourceStatus.success:
        print("Sign up success: ${result.data}");
        emit(SignUpSuccess(result.data!));
        break;
      case ResourceStatus.failure:
        print("Sign up error: ${result.message}");
        emit(SignUpFailure(result.message ?? "Unknown error occurred"));
        break;
      case ResourceStatus.loading:
        // This case shouldn't occur in this context, but handle it just in case
        emit(SignUpLoading());
        break;
    }
  }
}
