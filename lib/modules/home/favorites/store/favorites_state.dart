// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../crypto/domain/entities/crypto_asset_entity.dart';

class FavoritesState {
  final List<CryptoAssetEntity>? cryptos;
  final int actualPage;
  final List<Map>? favorites;
  final int limit = 20;

  static final initialState = FavoritesState();

  FavoritesState({this.cryptos, this.actualPage = 0, this.favorites});

  FavoritesState copyWith({List<CryptoAssetEntity>? cryptos, int? actualPage, List<Map>? favorites}) {
    return FavoritesState(
      cryptos: cryptos ?? this.cryptos,
      actualPage: actualPage ?? this.actualPage,
      favorites: favorites ?? this.favorites,
    );
  }
}
