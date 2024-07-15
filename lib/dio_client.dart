import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late final Dio dio;

  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    dio = Dio();
    dio.interceptors.add(dioLoggerInterceptor);
  }
}
