import 'package:TableTies/utils/resource.dart';
import 'package:http/http.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  // get user by id
  Future<dynamic> getUserById({required String userId}) async {
    try {
      Resource.loading();
      final user = await _client
          .from('users')
          .select('*') // Select all columns
          .eq('id', userId); // Filter by the 'id' column matching the userId
      print('Supabase retrived user successfuly: $user');

      return Resource.success(user);
    } catch (e) {
      print('Supabase get user by id error: $e');
      return Resource.failure(
          e.toString()); // Return a Resource with the error message
    }
  }
}
