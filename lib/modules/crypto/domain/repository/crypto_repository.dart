import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../entities/crypto_asset_entity.dart';
import '../entities/crypto_history_entity.dart';

abstract class CryptoRepository {
  Future<Either<Failure, List<CryptoAssetEntity>>> getCryptos({
    required int offset,
    required int limit,
    String? search,
    List<String>? idsToSearch,
  });
  Future<Either<Failure, void>> setFavorite(String id);
  Future<Either<Failure, List<Map>>> getFavorites();
  Future<Either<Failure, void>> deleteFavorite(String id);
  Future<Either<Failure, CryptoHistoryIntervalEntity>> getHistory(String idCrypto, {required HistoryInterval interval});
}
