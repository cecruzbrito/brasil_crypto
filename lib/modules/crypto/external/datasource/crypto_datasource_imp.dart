// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../../../core/errors/errors.dart';
import '../../../../core/services/api_request/domain/repositories/api_request_repository.dart';
import '../../../../core/services/cache_service/domain/entities/cache_keys.dart';
import '../../../../core/services/cache_service/domain/repository/cache_service_repository.dart';
import '../../domain/entities/crypto_asset_entity.dart';
import '../../domain/entities/crypto_history_entity.dart';
import '../../infra/datasource/crypto_datasource.dart';
import '../mappers/crypto_asset_mapper.dart';
import 'crypto_history_mapper.dart';

class CryptoDatasourceImp implements CryptoDatasource {
  final ApiRequestRepository _api;
  final CacheServiceRepository _cache;

  CryptoDatasourceImp(this._api, this._cache);
  @override
  Future<List<CryptoAssetEntity>> getCryptos({
    required int offset,
    required int limit,
    String? search,
    List<String>? idsToSearch,
  }) async {
    try {
      final response = await _api.get(
        "assets",
        queryParameters: {"limit": limit, "offset": offset * limit, "search": search, "ids": idsToSearch?.join(",")},
      );
      return response.fold((l) => throw l, (r) => (r["data"] as List).map(CryptoAssetMapper.fromJson).toList());
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<void> deleteFavorite(String id) async {
    try {
      final favorites = await getFavorites();
      final index = favorites.indexWhere((e) => e["id"] == id);
      if (index == -1) return;
      final response = await _cache.delete(CacheKeys.favorites, index);
      return response.fold((l) => throw l, (r) => r);
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<List<Map>> getFavorites() async {
    try {
      final response = await _cache.get(CacheKeys.favorites);
      return response.fold((l) => throw l, (r) => r);
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<void> setFavorite(String id) async {
    try {
      final response = await _cache.add(CacheKeys.favorites, data: {"id": id});
      return response.fold((l) => throw l, (r) => r);
    } on Failure {
      rethrow;
    }
  }

  @override
  Future<CryptoHistoryIntervalEntity> getHistory(String idCrypto, {required HistoryInterval interval}) async {
    try {
      final response = await _api.get("assets/$idCrypto/history", queryParameters: {"interval": interval.id});
      return response.fold(
        (l) => throw l,
        (r) => CryptoHistoryIntervalEntity(
          interval: interval,
          history: (r["data"] as List).map(CryptoHistoryMapper.fromJson).toList(),
        ),
      );
    } on Failure {
      rethrow;
    }
  }
}
