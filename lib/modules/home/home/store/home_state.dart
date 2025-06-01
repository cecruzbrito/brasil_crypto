// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brasilcripto/modules/crypto/domain/entities/crypto_asset_entity.dart';

class HomeState {
  final List<CryptoAssetEntity>? cryptos;
  final int actualPage;
  final String? lastSearch;
  final List<Map>? favorites;
  final int limit = 20;
  HomeState({this.cryptos, this.actualPage = 0, this.lastSearch, this.favorites});
  static final initialState = HomeState();

  HomeState copyWith({List<CryptoAssetEntity>? cryptos, int? actualPage, String? lastSearch, List<Map>? favorites}) {
    return HomeState(
      cryptos: cryptos ?? this.cryptos,
      actualPage: actualPage ?? this.actualPage,
      lastSearch: lastSearch ?? this.lastSearch,
      favorites: favorites ?? this.favorites,
    );
  }
}
