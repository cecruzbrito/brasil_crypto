import 'package:dartz/dartz.dart';

import '../../../../errors/errors.dart';
import '../../domain/entities/cache_keys.dart';
import '../../domain/repository/cache_service_repository.dart';
import '../datasource/cache_service_datasource.dart';

class CacheServiceRepositoryImp implements CacheServiceRepository {
  final CacheServiceDatasource _datasource;

  CacheServiceRepositoryImp(this._datasource);
  @override
  Future<Either<Failure, void>> delete(CacheKeys key, int index) async {
    try {
      return Right(await _datasource.delete(key, index));
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<Map>>> get(CacheKeys key) async {
    try {
      return Right(await _datasource.get(key));
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> put(CacheKeys key, {required Map<String, dynamic> data}) async {
    try {
      return Right(await _datasource.put(key, data: data));
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> add(CacheKeys key, {required Map<String, dynamic> data}) async {
    try {
      return Right(await _datasource.add(key, data: data));
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
