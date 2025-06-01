import '../../domain/entities/cache_keys.dart';

abstract class CacheServiceDatasource {
  Future<List<Map>> get(CacheKeys key);
  Future<Map<String, dynamic>> put(CacheKeys key, {required Map<String, dynamic> data});
  Future<Map<String, dynamic>> add(CacheKeys key, {required Map<String, dynamic> data});
  Future<void> delete(CacheKeys key, int index);
}
