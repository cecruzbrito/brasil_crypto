import 'package:dartz/dartz.dart';

import '../../../../errors/errors.dart';

abstract class ApiRequestRepository {
  Future<Either<Failure, dynamic>> get(String endpoint, {Map<String, dynamic>? queryParameters});
}
