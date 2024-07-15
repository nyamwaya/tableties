import 'dart:convert';

import 'package:TableTies/services/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginRepository {
  final DioClient client;

  LoginRepository({required this.client});

  Future<Map<String, dynamic>> login(String email, String password) async {
    final projectId = dotenv.env['STYTCH_PROJECT_ID'];
    final secret = dotenv.env['STYTCH_SECRET'];

    try {
      final response = await client.dio.post(
        'https://test.stytch.com/v1/passwords/authenticate',
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
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Login Failed');
      }
    } catch (e) {
      print("Login Error ${e.toString()}");
      throw Exception('Login error: ${e.toString()}');
    }
  }
}
