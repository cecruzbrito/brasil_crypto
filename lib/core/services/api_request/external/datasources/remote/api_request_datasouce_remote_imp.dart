import '../../../../../errors/errors.dart';
import '../../../../http_request/domain/repositories/http_request_repository.dart';
import '../../../domain/errors/api_request_errors.dart';
import '../../../infra/datasource/api_request_datasource.dart';

class ApiRequestDatasouceRemoteImp implements ApiRequestDatasource {
  final HttpRequestRepository _repository;
  final String baseUrl = "https://rest.coincap.io/v3/";
  ApiRequestDatasouceRemoteImp(this._repository);

  @override
  Future<dynamic> get(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    try {
      var params =
          (queryParameters ?? {})
            ..addAll({"apiKey": "906efc17f208e774d781d0369765e4017e1c8292b03a08569c481d9028542048"});
      final response = await _repository.get(baseUrl + endpoint, queryParameters: params);
      return response.fold((l) => throw l, (r) async {
        if (r.data == null) throw ApiHttpRequestFailure(msg: "Resposta inválida");
        return r.data;
      });
    } on Failure {
      rethrow;
    }
  }
}
