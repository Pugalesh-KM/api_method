import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart';

class DioClient {
  static Dio createDio() {
    final dio = Dio();

    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
        queryParameters: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        showProcessingTime: true,
        showCUrl: true,
        canShowLog: kDebugMode,
      ));
    }

    dio.options.connectTimeout = const Duration(milliseconds: 5000);
    dio.options.receiveTimeout = const Duration(milliseconds: 3000);

    return dio;
  }
}
