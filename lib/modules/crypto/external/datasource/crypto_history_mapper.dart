import '../../domain/entities/crypto_history_entity.dart';

class CryptoHistoryMapper {
  static CryptoHistoryEntity fromJson(dynamic json) =>
      CryptoHistoryEntity(priceUsd: json['priceUsd'], date: json['date'], circulatingSupply: json['circulatingSupply']);
}
