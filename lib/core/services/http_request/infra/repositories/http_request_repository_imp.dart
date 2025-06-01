import 'package:dio/dio.dart';

import '../../../../errors/errors.dart';
import 'package:dartz/dartz.dart';

import '../datasource/http_request_datasource.dart';
import '../../domain/repositories/http_request_repository.dart';

class HttpRequestRepositoryImp implements HttpRequestRepository {
  final HttpRequestDatasource _datasource;

  HttpRequestRepositoryImp(this._datasource);

  @override
  Future<Either<Failure, Response>> get(
    String endpoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return Right(await _datasource.get(endpoint, headers: headers, queryParameters: queryParameters));
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, Response>> post(String endpoint, {dynamic data, Map<String, dynamic>? headers}) async {
    try {
      return Right(await _datasource.post(endpoint, data: data, headers: headers));
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, Response>> delete(
    String endpoint, {
    data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return Right(await _datasource.delete(endpoint, data: data, headers: headers, queryParameters: queryParameters));
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, Response>> put(
    String endpoint, {
    data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return Right(await _datasource.put(endpoint, data: data, headers: headers, queryParameters: queryParameters));
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
