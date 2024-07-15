import 'package:dio/dio.dart';

class DioClient {
  static final DioClient _singleton = DioClient._internal();
  late Dio dio;

  factory DioClient() {
    return _singleton;
  }

  DioClient._internal() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://api.example.com',
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ));
  }
}
