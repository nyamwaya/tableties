import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:TableTies/repo/supabase_repo.dart';
import 'package:TableTies/state/profile_states.dart';
import 'package:TableTies/utils/utils.dart';
import 'package:TableTies/data_models/user_supabase.dart';
import 'package:TableTies/events/profile_events.dart'; // Adjust the import path as needed

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final SupabaseRepository supabaseRepository;

  ProfileBloc({required this.supabaseRepository}) : super(ProfileInitial()) {
    on<DisplayUserFromMemory>(_onGetUserFromMemory);
  }

  void _onProfileEvent(ProfileEvent event, Emitter<ProfileState> emit) {
    // TODO: Implement the logic for handling ProfileEvent
  }

// we first display the saved user object.
  void _onGetUserFromMemory(
      ProfileEvent event, Emitter<ProfileState> emit) async {
    final user = await getUserObject();
    final userId = await getUserId();

    if (user != null) {
      // are you emmiting this in the initial state is the right approah? what about just passing in a user object?
      emit(ProfileLoaded(user));
    } else if (user == null && userId != null) {
      final user = await supabaseRepository.getUserById(userId: userId);
      final fixedUser = user.data.toJson();
      saveUserObject(fixedUser);
    }
    //i doubt this would be the case, the false senario because if theres no object we log the user out.
  }
}
