import 'dart:convert';

import 'package:TableTies/repo/sign_up_repo.dart';
import 'package:TableTies/repo/supabase_repo.dart';
import 'package:TableTies/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';
import 'package:intl/intl.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpRepository repository;
  final SupabaseRepository supabaseRepository;

  SignUpBloc(
      {required this.repository,
      required SupabaseRepository this.supabaseRepository})
      : super(SignUpInitial()) {
    on<SignUpSubmitted>(_onSignUpSubmitted);
  }

  void _onSignUpSubmitted(
    SignUpSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoading());
    try {
      print('Calling repository.signUp()');
      var data =
          await repository.signUp(event.fullName, event.email, event.password);
      print('repository.signUp() returned: $data');

      List<String> nameparts = event.fullName.trim().split(" ");
      String createdAt = DateFormat("yyyy-MM-ddTHH:mm:ssZ")
          .format(DateTime.now()); // Get current timestamp with timezone

      print('Calling supabaseRepository.insertNewUser()');
      var dbResponse = await supabaseRepository.insertNewUser(
          id: data['user_id'],
          first_name: nameparts.first.trim(),
          last_name: nameparts.last.trim(),
          email: event.email,
          created_at: createdAt);
      print('supabaseRepository.insertNewUser() returned: $dbResponse');

      // there can be a senario where stytch returns a 200
      if (dbResponse != null) {
        saveUserSession(data['user_id']);
        //  you need to have a data object for the db response
        emit(SignUpSuccess(jsonEncode(dbResponse)));
      } else {
        emit(SignUpFailure('Failed to insert user in Supabase'));
      }
    } catch (e) {
      print('_onSignUpSubmitted error: $e');
      emit(SignUpFailure(e.toString()));
    }
  }
}
