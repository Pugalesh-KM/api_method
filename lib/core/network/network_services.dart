
import 'package:api_method/core/network/dio_log.dart';
import 'package:dio/dio.dart';

class NetworkServices {
  final dio = DioClient.createDio();
  final String baseUrl;

  NetworkServices({required this.baseUrl});

  Future<Response> get(String endpoint, {Map<String, dynamic>? params}) async {
    return await dio.get('$baseUrl$endpoint', queryParameters: params);
  }

  Future<Response> post(String endpoint, Map<String, dynamic> data) async {
    return await dio.post('$baseUrl$endpoint', data: data);
  }

  Future<Response> put(String endpoint, Map<String, dynamic> data) async {
    return await dio.put('$baseUrl$endpoint', data: data);
  }

  Future<Response> patch(String endpoint, Map<String, dynamic> data) async {
    return await dio.patch('$baseUrl$endpoint', data: data);
  }

  Future<Response> delete(String endpoint) async {
    return await dio.delete('$baseUrl$endpoint');
  }
}
