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

  // Add more methods as needed
}
