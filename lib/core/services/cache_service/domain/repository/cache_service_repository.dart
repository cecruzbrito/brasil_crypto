import 'package:dartz/dartz.dart';

import '../../../../errors/errors.dart';
import '../entities/cache_keys.dart';

abstract class CacheServiceRepository {
  Future<Either<Failure, List<Map>>> get(CacheKeys key);
  Future<Either<Failure, Map<String, dynamic>>> put(CacheKeys key, {required Map<String, dynamic> data});
  Future<Either<Failure, Map<String, dynamic>>> add(CacheKeys key, {required Map<String, dynamic> data});
  Future<Either<Failure, void>> delete(CacheKeys key, int index);
}
