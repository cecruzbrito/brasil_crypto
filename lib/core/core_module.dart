import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'services/api_request/domain/repositories/api_request_repository.dart';
import 'services/api_request/external/datasources/remote/api_request_datasouce_remote_imp.dart';
import 'services/api_request/infra/datasource/api_request_datasource.dart';
import 'services/api_request/infra/repositories/api_request_repository_imp.dart';
import 'services/cache_service/domain/repository/cache_service_repository.dart';
import 'services/cache_service/external/datasource/local/cache_service_local_datasource_imp.dart';
import 'services/cache_service/infra/datasource/cache_service_datasource.dart';
import 'services/cache_service/infra/repositories/cache_service_repository_imp.dart';
import 'services/env/domain/repository/env_repository.dart';
import 'services/env/external/datasource/env_datasource_imp.dart';
import 'services/env/infra/datasource/env_datasource.dart';
import 'services/env/infra/repository/env_repository_imp.dart';
import 'services/http_request/domain/repositories/http_request_repository.dart';
import 'services/http_request/external/datasources/remote/http_request_datasource_remote_imp.dart';
import 'services/http_request/infra/datasource/http_request_datasource.dart';
import 'services/http_request/infra/repositories/http_request_repository_imp.dart';

class CoreModule extends Module {
  @override
  void exportedBinds(Injector i) {
    super.exportedBinds(i);
    i.addInstance(Dio());
    // HTTPS
    i.add<HttpRequestDatasource>(HttpRequestDatasourceRemoteImp.new);
    i.add<HttpRequestRepository>(HttpRequestRepositoryImp.new);
    // API
    i.add<ApiRequestDatasource>(ApiRequestDatasouceRemoteImp.new);
    i.add<ApiRequestRepository>(ApiRequestRepositoryImp.new);
    // CACHE
    i.add<CacheServiceRepository>(CacheServiceRepositoryImp.new);
    i.add<CacheServiceDatasource>(CacheServiceLocalDatasourceImp.new);
    // REMOTE ENV
    i.add<EnvRepository>(EnvRepositoryImp.new);
    i.add<EnvDatasource>(EnvDatasourceImp.new);
  }
}
