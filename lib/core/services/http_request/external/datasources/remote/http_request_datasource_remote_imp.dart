import 'dart:io';

import 'package:dio/dio.dart';

import '../../../domain/errors/http_request_errors.dart';
import '../../../infra/datasource/http_request_datasource.dart';

class HttpRequestDatasourceRemoteImp implements HttpRequestDatasource {
  final Dio _dio;

  HttpRequestDatasourceRemoteImp(this._dio);
  @override
  Future<Response> get(String endpoint, {Map<String, dynamic>? headers, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: queryParameters, options: Options(headers: headers));
      return response;
    } on DioException catch (e) {
      throw FailureHttpRequest(msg: _handleDioError(e));
    } catch (e) {
      throw FailureHttpRequest(msg: 'Ocorreu um erro inesperado.');
    }
  }

  @override
  Future<Response> post(String endpoint, {dynamic data, Map<String, dynamic>? headers}) async {
    try {
      return await _dio.post(endpoint, data: data, options: Options(headers: headers));
    } on DioException catch (e) {
      throw FailureHttpRequest(msg: _handleDioError(e));
    } catch (e) {
      throw FailureHttpRequest(msg: 'Ocorreu um erro inesperado.');
    }
  }

  @override
  Future<Response> delete(
    String endpoint, {
    data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.delete(endpoint, data: data, options: Options(headers: headers));
    } on DioException catch (e) {
      throw FailureHttpRequest(msg: _handleDioError(e));
    } catch (e) {
      throw FailureHttpRequest(msg: 'Ocorreu um erro inesperado.');
    }
  }

  @override
  Future<Response> put(
    String endpoint, {
    data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.put(endpoint, data: data, options: Options(headers: headers));
    } on DioException catch (e) {
      throw FailureHttpRequest(msg: _handleDioError(e));
    } catch (e) {
      throw FailureHttpRequest(msg: 'Ocorreu um erro inesperado.');
    }
  }

  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return 'Requisição cancelada.';
      case DioExceptionType.connectionTimeout:
        return 'Tempo de conexão excedido.';
      case DioExceptionType.receiveTimeout:
        return 'Tempo de resposta excedido.';
      case DioExceptionType.sendTimeout:
        return 'Tempo de envio excedido.';
      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response?.statusCode, error.response?.data);
      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return 'Sem conexão com a internet.';
        }
        return 'Erro desconhecido.';
      default:
        return 'Erro desconhecido.';
    }
  }

  String _handleBadResponse(int? statusCode, dynamic data) {
    if (statusCode == null) return 'Erro na resposta.';
    switch (statusCode) {
      case 400:
        return data['message'] ?? 'Requisição inválida.';
      case 401:
        return 'Não autorizado.';
      case 404:
        return 'Recurso não encontrado.';
      case 500:
        return 'Erro no servidor.';
      default:
        return 'Erro na resposta ($statusCode).';
    }
  }
}
