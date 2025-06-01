import 'package:dio/dio.dart';

abstract class HttpRequestDatasource {
  Future<Response> get(String endpoint, {Map<String, dynamic>? headers, Map<String, dynamic>? queryParameters});
  Future<Response> post(String endpoint, {dynamic data, Map<String, dynamic>? headers});
  Future<Response> put(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  });
  Future<Response> delete(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  });
}
