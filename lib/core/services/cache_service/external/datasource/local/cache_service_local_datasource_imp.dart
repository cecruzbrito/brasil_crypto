import 'package:brasilcripto/core/services/cache_service/domain/entities/cache_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_ce/hive.dart';

import '../../../../../errors/errors.dart';
import '../../../domain/erros/cache_erros.dart';
import '../../../infra/datasource/cache_service_datasource.dart';

class CacheServiceLocalDatasourceImp extends CacheServiceDatasource {
  Future<Box<Map>> openBox(CacheKeys key) async => await Hive.openBox<Map>(key.name);

  @override
  Future<void> delete(CacheKeys key, int index) async {
    try {
      final ctr = await openBox(key);
      await ctr.deleteAt(index);
      // await ctr.close();
    } on HiveError catch (e) {
      throw FailureCache(msg: kDebugMode ? e.message : "Algo inesperado ocorreu ao apagar o cache");
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<List<Map>> get(CacheKeys key) async {
    try {
      final ctr = await openBox(key);
      final response = ctr.values.toList();
      // await ctr.close();

      return response;
    } on HiveError catch (e) {
      throw FailureCache(msg: kDebugMode ? e.message : "Algo inesperado ocorreu ao apagar o cache");
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> put(CacheKeys key, {required Map<String, dynamic> data}) async {
    try {
      var ctr = await openBox(key);
      await ctr.deleteFromDisk();
      ctr = await openBox(key);
      ctr.add(data);
      return data;
    } on HiveError catch (e) {
      throw FailureCache(msg: kDebugMode ? e.message : "Algo inesperado ocorreu ao apagar o cache");
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> add(CacheKeys key, {required Map<String, dynamic> data}) async {
    try {
      final ctr = await openBox(key);
      await ctr.add(data);
      // await ctr.close();
      return data;
    } on HiveError catch (e) {
      throw FailureCache(msg: kDebugMode ? e.message : "Algo inesperado ocorreu ao apagar o cache");
    } on Failure {
      rethrow;
    }
  }
}
