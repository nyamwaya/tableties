import 'dart:convert';

import 'package:TableTies/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginRepository {
  final DioClient client;

  LoginRepository({required this.client});

  Future<String> login(String email, String password) async {
    final projectId = dotenv.env[dotenv.env['STYTCH_PROJECT_ID']];
    final secret = dotenv.env[dotenv.env['STYTCH_SECRET']];

    try {
      final response = await client.dio.post(
        'https://api.stytch.com/v1/passwords/authenticate',
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
        return response.data.toString();
      } else {
        throw Exception('Login Failed');
      }
    } catch (e) {
      print("Login Error ${e.toString()}");
      throw Exception('Login error: ${e.toString()}');
    }
  }
}
