import 'dart:convert';

import 'package:TableTies/data_models/interests_model.dart';
import 'package:TableTies/data_models/user_profile_model.dart';
import 'package:TableTies/repo/supabase_repo.dart';
import 'package:TableTies/utils/resource.dart';
import 'package:TableTies/utils/utils.dart';

class ProfileREpository {
  final SupabaseRepository supabaseRepository;

  ProfileREpository({required this.supabaseRepository});

  Future<Resource<UserProfile>> getUserProfile() async {
    try {
      // 0. get a user id ..maybe change this later to get a live user id instead
      final userId = await getUserId() as String;

      // 1. Fetch basic user info
      final userResult = await supabaseRepository.getUserById(userId: userId);

      if (userResult == Resource.failure) {
        return Resource.failure(userResult.message);
      }
      final user = userResult.data;

      // 2. Fetch user interests (assuming you have a method for this)
      final interestsResult =
          await supabaseRepository.getUserInterests(userId: userId);
      if (interestsResult.status == ResourceStatus.failure) {
        return Resource.failure(interestsResult.data!);
      }
      final interests = interestsResult.data ?? ''; // Handle potential null
      final parsedInterests = parseInterests(interests);

      // 3. Construct the UserProfile
      final userProfile = UserProfile.fromUserSupabase(user)
          .copyWith(interests: parsedInterests);

      return Resource.success(userProfile);
    } catch (e) {
      // Log the error with class name
      print('Error in ProfileRepository: $e');
      return Resource.failure('Failed to fetch user profile');
    }
  }

  List<Interest> parseInterests(String jsonString) {
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Interest.fromJson(json)).toList();
  }
}
