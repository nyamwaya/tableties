import 'package:TableTies/data_models/user_supabase.dart';
import 'package:TableTies/utils/resource.dart';
import 'package:http/http.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert';

class SupabaseRepository {
  final SupabaseClient _client;

  SupabaseRepository(this._client);

  // Add Supabase-specific methods here

  //Insert a new user
  Future<dynamic> insertNewUser(
      {required String id,
      required String first_name,
      required String last_name,
      required String email,
      required String created_at}) async {
    try {
      final response = await _client.from('users').insert({
        'id': id,
        'first_name': first_name,
        'last_name': last_name,
        'email': email,
        'created_at': created_at
      }).select('*');

      // if (response.error != null) {
      //   print('Supabase insert error: ${response.error!.message}');
      //   return response.error!.message;
      // }

      print('Supabase insert successful: $response');
      return response;
    } catch (e) {
      print('Supabase insert error: $e');
      rethrow;
    }
  }

  // the idea is to first get get an updated user state.
  Future<dynamic> getUserById({required String userId}) async {
    try {
      Resource.loading();
      final userResponse = await _client
          .from('users')
          .select('*') // Select all columns
          .eq('id', userId); // Filter by the 'id' column matching the userId
      print('retrived Supabase user successfuly: $userResponse');

      // serialize the json into an object.
      final userData = userResponse[0];

      final userModel = UserSupabase.fromJson(userData);
      // send the data model not the direct json here
      return Resource.success(userModel);
    } catch (e) {
      print('Supabase get user by id error: $e');
      return Resource.failure(
          e.toString()); // Return a Resource with the error message
    }
  }

  /// Checks if a user's profile is complete and returns missing fields if any.
  /// Always returns a successful Resource, even if there are missing fields.
  Future<Resource<List<String>>> isProfileComplete(
      {required String userId}) async {
    try {
      print('User ID: $userId (type: ${userId.runtimeType})');

      final response = await _client.from('users').select('''
          profile_photo, 
          first_name, 
          last_name, 
          user_interests (interests)
        ''').eq('id', userId).single();

      final userInterests = (response['user_interests'] as List?)
          ?.map((item) => item['interests'])
          .toList();

      final List<String> missingFields = [];

      if (response['photo'] == null) {
        missingFields.add('photo');
      }
      if (response['first_name'] == null) {
        missingFields.add('first_name');
      }
      if (response['last_name'] == null) {
        missingFields.add('last_name');
      }
      if (userInterests == null || userInterests.isEmpty) {
        missingFields.add('user_interests');
      }
      return Resource.success(
          missingFields); // Always return success, even with missing fields
    } on PostgrestException catch (e) {
      print('Postgrest error checking profile completion: $e');
      return Resource.failure('Database error: ${e.message}');
    } catch (e) {
      print('Error checking profile completion: $e');
      return Resource.failure(
          'Failed to check profile completion: ${e.toString()}');
    }
  }

  // Function to fetch user interests and build a response
  Future<Resource<String>> getUserInterests({required String userId}) async {
    try {
      // Query the user_interests table for the given user
      final response = await _client
          .from('user_interests')
          .select('interests')
          .eq('user_id', userId)
          .limit(1)
          .maybeSingle();

      // If no data is found, return a success response with "no data"
      if (response == null || response['interests'] == null) {
        return Resource.success("User has no interests");
      }

      // Convert the interests to a list of integers
      List<String> interestUUIDs = List<String>.from(response['interests']);

      // return Resource.success(interestIds.toList() as String);
      // Build and return the detailed interests response
      return Resource.success(await _buildInterestsResponse(interestUUIDs));
    } catch (e) {
      print('Error fetching user interests: $e');
      return Resource.failure(
          'Failed to fetch user interests: ${e.toString()}');
    }
  }

  // Function to build a detailed response for a list of interest IDs
  Future<String> _buildInterestsResponse(List<String> interestUUIDs) async {
    List<Map<String, dynamic>> interestsData = [];

    // Fetch detailed data for each interest ID
    for (String interestId in interestUUIDs) {
      final interestData = await _getInterestData(interestId);
      if (interestData != null) {
        interestsData.add(interestData);
      }
    }

    // Convert the list of interest data to a JSON string
    return json.encode(interestsData);
  }

  // Function to fetch detailed data for a single interest
  Future<Map<String, dynamic>?> _getInterestData(String interestId) async {
    try {
      // Query the interests table for the given interest ID
      final interestResponse = await _client
          .from('interests')
          .select('id, name, category_id')
          .eq('id', interestId)
          .single();

      // Fetch the category name for this interest
      final categoryName =
          await _getCategoryName(interestResponse['category_id']);

      // Build and return a map with interest and category details
      return {
        'interest_id': interestResponse['id'],
        'interest_name': interestResponse['name'],
        'category_id': interestResponse['category_id'],
        'category_name': categoryName,
      };
    } catch (e) {
      print('Error fetching interest data: $e');
      return null;
    }
  }

  // Function to fetch the category name for a given category ID
  Future<String> _getCategoryName(String categoryId) async {
    try {
      // Query the categories table for the given category ID
      final categoryResponse = await _client
          .from('categories')
          .select('name')
          .eq('id', categoryId)
          .single();

      final categoryResult = categoryResponse['name'] ?? 'Unknown Category';
      return categoryResult;
    } catch (e) {
      print('Error fetching category name: $e');
      return 'Unknown Category';
    }
  }

  // Function to update user information
  Future<Resource<Map<String, dynamic>>> updateUser({
    required String userId,
    required Map<String, dynamic> updatedFields,
  }) async {
    try {
      final response = await _client
          .from('users')
          .update(updatedFields)
          .eq('id', userId)
          .select()
          .single();

      return Resource.success(response);
    } catch (e) {
      print('Error updating user: $e');
      return Resource.failure('An error occurred while updating user');
    }
  }

  // Function to update user interests
  Future<Resource<List<Map<String, dynamic>>>> updateUserInterests({
    required String userId,
    required List<String> interestIds,
  }) async {
    try {
      // First, delete all existing interests for the user
      await _client.from('user_interests').delete().eq('user_id', userId);

      // Then, insert the new interests
      final insertData = interestIds
          .map((interestId) => {
                'user_id': userId,
                'interest_id': interestId,
              })
          .toList();

      final response =
          await _client.from('user_interests').insert(insertData).select();

      return Resource.success(response);
    } catch (e) {
      print('Error updating user interests: $e');
      return Resource.failure(
          'An error occurred while updating user interests');
    }
  }

  // Function to update both user information and interests
  Future<Resource<Map<String, dynamic>>> updateUserProfile({
    required String userId,
    Map<String, dynamic>? userFields,
    List<String>? interestIds,
  }) async {
    try {
      if (userFields != null && userFields.isNotEmpty) {
        final userUpdateResult = await updateUser(
          userId: userId,
          updatedFields: userFields,
        );
        if (userUpdateResult.status == ResourceStatus.failure) {
          return Resource.failure(userUpdateResult.data.toString() ??
              'Failed to update user profile');
        }
      }

      if (interestIds != null && interestIds.isNotEmpty) {
        final interestsUpdateResult = await updateUserInterests(
          userId: userId,
          interestIds: interestIds,
        );
        if (interestsUpdateResult.status == ResourceStatus.failure) {
          return Resource.failure(interestsUpdateResult.data.toString() ??
              'Failed to update user interests');
        }
      }

      // Fetch and return the updated user profile
      final updatedProfile = await getUserById(userId: userId);
      if (updatedProfile == null) {
        return Resource.failure('Failed to fetch updated user profile');
      }

      return Resource.success(updatedProfile);
    } catch (e) {
      print('Error updating user profile: $e');
      return Resource.failure('An error occurred while updating user profile');
    }
  }
}
