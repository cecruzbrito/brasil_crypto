abstract class ApiRequestDatasource {
  Future<dynamic> get(String endpoint, {Map<String, dynamic>? queryParameters});
}
