import 'package:brasilcripto/core/services/env/domain/entites/keys_env.dart';

abstract class EnvDatasource {
  Future<String> getString(KeysEnv key);
}
