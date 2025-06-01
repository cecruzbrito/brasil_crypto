import 'package:brasilcripto/core/errors/errors.dart';
import 'package:brasilcripto/core/services/env/domain/entites/keys_env.dart';
import 'package:brasilcripto/core/services/env/domain/repository/env_repository.dart';
import 'package:brasilcripto/core/services/env/infra/datasource/env_datasource.dart';
import 'package:dartz/dartz.dart';

class EnvRepositoryImp implements EnvRepository {
  final EnvDatasource _datasource;

  EnvRepositoryImp(this._datasource);
  @override
  Future<Either<Failure, String>> getString(KeysEnv key) async {
    try {
      return Right(await _datasource.getString(key));
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
