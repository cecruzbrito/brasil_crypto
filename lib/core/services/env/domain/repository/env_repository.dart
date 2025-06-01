import 'package:brasilcripto/core/errors/errors.dart';
import 'package:brasilcripto/core/services/env/domain/entites/keys_env.dart';
import 'package:dartz/dartz.dart';

abstract class EnvRepository {
  Future<Either<Failure, String>> getString(KeysEnv key);
}
