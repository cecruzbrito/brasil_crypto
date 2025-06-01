import 'package:brasilcripto/core/services/env/domain/entites/keys_env.dart';
import 'package:brasilcripto/core/services/env/domain/repository/env_repository.dart';

import '../../../../../errors/errors.dart';
import '../../../../http_request/domain/repositories/http_request_repository.dart';
import '../../../domain/errors/api_request_errors.dart';
import '../../../infra/datasource/api_request_datasource.dart';

class ApiRequestDatasouceRemoteImp implements ApiRequestDatasource {
  final HttpRequestRepository _repository;
  final EnvRepository _env;
  final String baseUrl = "https://rest.coincap.io/v3/";
  ApiRequestDatasouceRemoteImp(this._repository, this._env);

  @override
  Future<dynamic> get(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    try {
      final apiKey = (await _env.getString(KeysEnv.apiKey)).fold((l) => throw l, (r) => r);

      var params = (queryParameters ?? {})..addAll({"apiKey": apiKey});
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
