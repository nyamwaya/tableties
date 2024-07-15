import 'dart:convert';
import 'package:TableTies/dio_client.dart';
import 'package:TableTies/resource.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SignUpRepository {
  final Dio _dio = DioClient().dio;

  Future<Resource<String>> signUp(
      String fullName, String email, String password) async {
    final projectId = dotenv.env['STYTCH_PROJECT_ID'];
    final secret = dotenv.env['STYTCH_SECRET'];

    try {
      final response = await _dio.post(
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
        return Resource.success(response.data.toString());
      } else {
        return Resource.failure('Sign up failed');
      }
    } catch (e) {
      return Resource.failure('An error occurred: ${e.toString()}');
    }
  }
}
