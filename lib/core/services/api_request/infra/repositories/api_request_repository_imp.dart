import 'package:dartz/dartz.dart';

import '../../../../errors/errors.dart';
import '../../domain/repositories/api_request_repository.dart';
import '../datasource/api_request_datasource.dart';

class ApiRequestRepositoryImp implements ApiRequestRepository {
  final ApiRequestDatasource _datasource;

  ApiRequestRepositoryImp(this._datasource);

  @override
  Future<Either<Failure, dynamic>> get(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    try {
      return Right(await _datasource.get(endpoint, queryParameters: queryParameters));
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
