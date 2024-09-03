import 'dart:convert';
import 'package:TableTies/repo/profile_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:TableTies/repo/supabase_repo.dart';
import 'package:TableTies/state/profile_states.dart';
import 'package:TableTies/utils/utils.dart';
import 'package:TableTies/data_models/user_supabase.dart';
import 'package:TableTies/events/profile_events.dart'; // Adjust the import path as needed
import 'package:TableTies/data_models/user_profile_model.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileREpository profileREpository;

  ProfileBloc({required this.profileREpository}) : super(ProfileInitial()) {
    on<DisplayUserFromMemory>(_onGetUserFromMemory);
  }

  void _onProfileEvent(ProfileEvent event, Emitter<ProfileState> emit) {
    // TODO: Implement the logic for handling ProfileEvent
  }

// we first display the saved user object.
  void _onGetUserFromMemory(
      DisplayUserFromMemory event, Emitter<ProfileState> emit) async {
    try {
      final user = await getUserObject();

      if (user != null) {
        final userMap = jsonDecode(user) as Map<String, dynamic>;
        final userObject = UserSupabase.fromJson(userMap);

        emit(ProfileLoaded(UserProfile.fromUserSupabase(userObject)));
      } else {
        // concider passing in a user id.
        final result = await profileREpository.getUserProfile();
        emit(ProfileLoaded(result.data!));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
