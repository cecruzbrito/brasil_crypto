import '../../domain/entities/crypto_asset_entity.dart';
import '../../domain/entities/crypto_history_entity.dart';

abstract class CryptoDatasource {
  Future<List<CryptoAssetEntity>> getCryptos({
    required int offset,
    required int limit,
    String? search,
    List<String>? idsToSearch,
  });

  Future<void> setFavorite(String id);
  Future<List<Map>> getFavorites();
  Future<void> deleteFavorite(String id);
  Future<CryptoHistoryIntervalEntity> getHistory(String idCrypto, {required HistoryInterval interval});
}
