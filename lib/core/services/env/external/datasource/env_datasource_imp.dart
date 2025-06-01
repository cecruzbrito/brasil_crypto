import 'package:brasilcripto/core/services/env/domain/entites/keys_env.dart';
import 'package:brasilcripto/core/services/env/domain/errors/erros.dart';
import 'package:brasilcripto/core/services/env/infra/datasource/env_datasource.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class EnvDatasourceImp implements EnvDatasource {
  @override
  Future<String> getString(KeysEnv key) async {
    try {
      await FirebaseRemoteConfig.instance.fetchAndActivate();
      return FirebaseRemoteConfig.instance.getString(key.key);
    } on FirebaseException catch (e) {
      throw FailureEnv(msg: (kDebugMode ? e.message : null) ?? "Ocorreu um erro desconhecido");
    }
  }
}
