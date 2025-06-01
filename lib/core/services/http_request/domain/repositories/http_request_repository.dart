import 'package:dio/dio.dart';

import '../../../../errors/errors.dart';
import 'package:dartz/dartz.dart';

abstract class HttpRequestRepository {
  Future<Either<Failure, Response>> get(
    String endpoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  });
  Future<Either<Failure, Response>> post(String endpoint, {dynamic data, Map<String, dynamic>? headers});

  Future<Either<Failure, Response>> delete(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  });
  Future<Either<Failure, Response>> put(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  });
}
