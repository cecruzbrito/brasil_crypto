import '../../domain/entities/crypto_asset_entity.dart';

class CryptoAssetMapper {
  static CryptoAssetEntity fromJson(dynamic json) {
    return CryptoAssetEntity(
      id: json['id'] as String?,
      rank: json['rank']?.toString(),
      symbol: json['symbol'] as String?,
      name: json['name'] as String?,
      supply: json['supply']?.toString(),
      maxSupply: json['maxSupply']?.toString(),
      marketCapUsd: json['marketCapUsd']?.toString(),
      volumeUsd24Hr: json['volumeUsd24Hr']?.toString(),
      priceUsd: json['priceUsd']?.toString(),
      changePercent24Hr: json['changePercent24Hr']?.toString(),
      vwap24Hr: json['vwap24Hr']?.toString(),
      explorer: json['explorer'] as String?,
      tokens:
          (json['tokens'] != null)
              ? Map<String, List<String>>.from(
                json['tokens'].map((key, value) => MapEntry(key, List<String>.from(value ?? []))),
              )
              : null,
    );
  }
}
