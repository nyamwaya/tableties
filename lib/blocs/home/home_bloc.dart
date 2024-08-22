import 'dart:convert';

import 'package:TableTies/data_models/user_supabase.dart';
import 'package:TableTies/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:TableTies/events/home_event.dart';
import 'package:TableTies/repo/supabase_repo.dart';
import 'package:TableTies/utils/resource.dart';
import 'package:TableTies/state/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState<Resource>> {
  final SupabaseRepository supabaseRepository;

  HomeBloc({required SupabaseRepository this.supabaseRepository})
      : super(HomeInitial()) {
    on<CacheUser>(_getCachedOrFetchedUser);
    // on<GetUser>(_onGetUser); // Use _onGetUser instead of __onGetUser
  }

  void _getCachedOrFetchedUser(CacheUser event, Emitter<HomeState> emit) async {
    final cachedUserJson = getUserObject;

    if (cachedUserJson.toString().isNotEmpty) {
      // Use cached user if available
      final user = UserSupabase.fromJson(jsonDecode(cachedUserJson as String));

      // Trigger background fetch to update the cache (we'll implement this later)
      final response = await _fetchAndUpdateUser(user.id);

      if (response == Resource.success) {
        final updatedUser = response.data as UserSupabase;
        emit(HomeSuccess(Resource.success(updatedUser)));
      } else {
        // If fetch fails, still use the cached user
        emit(HomeSuccess(Resource.success(user)));
      }
    } else {
      // No cached user, fetch user from the server
      final userId = getUserId() as String;
      if (userId.isNotEmpty) {
        final response = await _fetchAndUpdateUser(userId);
        if (response == ResourceStatus.success) {
          final user = response.data as UserSupabase;
          emit(HomeSuccess(Resource.success(user)));
        } else if (response == ResourceStatus.failure) {
          emit(HomeFailure(
              Resource.failure(response.error ?? "Failed to fetch user")));
        }
      } else {
        emit(HomeFailure(Resource.success("User ID not found")));
      }
    }
  }

  Future<Resource> _fetchAndUpdateUser(String userId) async {
    try {
      // Fetch the latest user data from Supabase using userId
      final userId = getUserId();
      final response = await supabaseRepository.getUserById(
          userId: userId
              as String); // Assuming you have this method in your SupabaseRepository

      if (response == ResourceStatus.success) {
        final user = response.data;

        saveUserObject(user.toJson().toString());
        //emmit the success state
      } else if (response == ResourceStatus.failure) {
        // Handle the error if fetching fails (e.g., log it or show a message)
        print('Error fetching user: ${response.message}');
      }

      return response;
    } catch (e) {
      // Handle any unexpected exceptions
      print('Error fetching and updating user: $e');
      return Resource.failure(
          e.toString()); // Return a failure Resource with the error message
    }
  }
}
