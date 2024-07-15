import 'dart:convert';

import 'package:TableTies/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SignUpRepository {
  final DioClient client;

  SignUpRepository({required this.client});

  Future<String> signUp(String fullName, String email, String password) async {
    final projectId = dotenv.env['STYTCH_PROJECT_ID'];
    final secret = dotenv.env['STYTCH_SECRET'];

    try {
      final response = await client.dio.post(
        'https://test.stytch.com/v1/passwords',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Basic ${base64Encode(utf8.encode('$projectId:$secret'))}',
          },
        ),
        data: {
          'email': email,
          'password': password,
          'name': {
            'first_name': fullName,
          },
        },
      );

      if (response.statusCode == 200) {
        return response.data.toString(); // Return the JSON string
      } else {
        throw Exception('Sign up failed');
      }
    } catch (e) {
      throw Exception('An error occurred: ${e.toString()}');
    }
  }
}
