import '../../../../core/mixin/string_mixin.dart';

class CryptoAssetEntity with StringMixin {
  final String? id;
  final String? rank;
  final String? symbol;
  final String? name;
  final String? supply;
  final String? maxSupply;
  final String? marketCapUsd;
  final String? volumeUsd24Hr;
  final String? priceUsd;
  final String? changePercent24Hr;
  final String? vwap24Hr;
  final String? explorer;
  final Map<String, List<String>>? tokens;

  CryptoAssetEntity({
    this.id,
    this.rank,
    this.symbol,
    this.name,
    this.supply,
    this.maxSupply,
    this.marketCapUsd,
    this.volumeUsd24Hr,
    this.priceUsd,
    this.changePercent24Hr,
    this.vwap24Hr,
    this.explorer,
    this.tokens,
  });

  String getChangePercent24Hr() => formatChangePercent(changePercent24Hr);

  String getVolumeUsd24Hr() => formatMoney(volumeUsd24Hr, symbol: "USD \$");

  String getPrice() => formatMoney(priceUsd, symbol: "USD \$");

  bool filterByNameOrSymbol(String value) => compareString(symbol ?? "", value) || compareString(name ?? "", value);

  String getSuply() => '${formatBigNumber(supply)} $symbol';

  String getMaxSuply() => '${formatBigNumber(maxSupply)} $symbol';

  String getMarketCapUsd() => formatMoney(marketCapUsd, symbol: "USD \$");

  String getVwap24Hr() => formatMoney(vwap24Hr, symbol: "USD \$");
}
