import 'dart:convert';
import 'package:TableTies/repo/profile_repo.dart';
import 'package:TableTies/utils/resource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:TableTies/repo/supabase_repo.dart';
import 'package:TableTies/state/profile_states.dart';
import 'package:TableTies/utils/utils.dart';
import 'package:TableTies/data_models/user_supabase.dart';
import 'package:TableTies/events/profile_events.dart'; // Adjust the import path as needed

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  //final SupabaseRepository supabaseRepository;
  final ProfileREpository profileREpository;

  ProfileBloc({required this.profileREpository}) : super(ProfileInitial()) {
    // on<DisplayUserFromMemory>(_onGetUserFromMemory);
    //  on<BuildUserInterests>(_onBuildUserInterests);
    on<LoadUserProfile>(_onLoadUserProfile);
  }

  void _onLoadUserProfile(
      LoadUserProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final result = await profileREpository.getUserProfile();
    if (result.status == ResourceStatus.success) {
      // Data fetched successfully
      final userProfile = result.data!; // Access the UserProfile data
      emit(ProfileLoaded(userProfile));
    } else if (result.status == ResourceStatus.failure) {
      // Error occurred
      final errorMessage = result.error!; // Access the error message
      emit(ProfileError(errorMessage));
    }
    // No need to handle ResourceStatus.loading here, as we already emitted ProfileLoading initially
  }

// // we first display the saved user object.
//   void _onGetUserFromMemory(
//       ProfileEvent event, Emitter<ProfileState> emit) async {
//     final user = await getUserObject();
//     final userId = await getUserId();

//     if (user != null) {
//       // are you emmiting this in the initial state is the right approah? what about just passing in a user object?
//       emit(ProfileLoaded(user));
//     } else if (user == null && userId != null) {
//       final user = await supabaseRepository.getUserById(userId: userId);
//       final fixedUser = user.data.toJson();
//       saveUserObject(fixedUser);
//     }
//     //i doubt this would be the case, the false senario because if theres no object we log the user out.
//   }

//   void _onBuildUserInterests(
//       BuildUserInterests event, Emitter<ProfileState> emit) async {
//     try {
//       emit(ProfileLoading());
//       final userInterestsResource =
//           await supabaseRepository.getUserInterests(userId: event.userId);
//       final userInterests =
//           userInterestsResource.data ?? ""; // Extract the actual data
//       emit(ProfileLoaded(userInterests));
//     } catch (e) {
//       // Handle the error appropriately
//       emit(ProfileError("Failed to build user interests:" + e.toString()));
//     }
//   }
}
