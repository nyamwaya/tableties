import 'package:dio/dio.dart';
import 'dio_client.dart';
import 'resource.dart';

class AuthRepository {
  final DioClient dioClient;

  AuthRepository({required this.dioClient});

  Future<Resource<void>> login(String username, String password) async {
    try {
      final response = await dioClient.dio.post('/login', data: {
        'username': username,
        'password': password,
      });

      if (response.statusCode == 200) {
        return Resource.success(null);
      } else {
        return Resource.failure('Failed to login');
      }
    } catch (e) {
      return Resource.failure(e.toString());
    }
  }

  Future<Resource<void>> logout() async {
    try {
      // Perform logout operation, e.g., clear tokens, notify server, etc.
      return Resource.success(null);
    } catch (e) {
      return Resource.failure(e.toString());
    }
  }
}
