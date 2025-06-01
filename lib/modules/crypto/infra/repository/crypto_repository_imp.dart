import 'package:brasilcripto/core/errors/errors.dart';
import 'package:brasilcripto/modules/crypto/domain/entities/crypto_asset_entity.dart';
import 'package:brasilcripto/modules/crypto/domain/entities/crypto_history_entity.dart';
import 'package:brasilcripto/modules/crypto/domain/repository/crypto_repository.dart';
import 'package:dartz/dartz.dart';

import '../datasource/crypto_datasource.dart';

class CryptoRepositoryImp implements CryptoRepository {
  final CryptoDatasource _datasource;

  CryptoRepositoryImp(this._datasource);
  @override
  Future<Either<Failure, List<CryptoAssetEntity>>> getCryptos({
    required int offset,
    required int limit,
    String? search,
    List<String>? idsToSearch,
  }) async {
    try {
      return Right(
        await _datasource.getCryptos(offset: offset, search: search, limit: limit, idsToSearch: idsToSearch),
      );
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, void>> deleteFavorite(String id) async {
    try {
      return Right(await _datasource.deleteFavorite(id));
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<Map>>> getFavorites() async {
    try {
      return Right(await _datasource.getFavorites());
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, void>> setFavorite(String id) async {
    try {
      return Right(await _datasource.setFavorite(id));
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, CryptoHistoryIntervalEntity>> getHistory(
    String idCrypto, {
    required HistoryInterval interval,
  }) async {
    try {
      return Right(await _datasource.getHistory(idCrypto, interval: interval));
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
