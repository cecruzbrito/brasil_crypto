// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brasilcripto/modules/crypto/domain/entities/crypto_asset_entity.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'package:brasilcripto/modules/home/favorites/store/favorites_state.dart';

import '../../../../core/widgets/snack_bars/core_snack_bar_success.dart';
import '../../../crypto/domain/repository/crypto_repository.dart';

class FavoritesStore extends Store<FavoritesState> {
  final CryptoRepository _crypto;

  FavoritesStore(this._crypto) : super(FavoritesState.initialState);

  Future<void> getFavorites() async {
    setLoading(true);
    final response = await _crypto.getFavorites();
    setLoading(false);

    return response.fold((l) => setError(l.copyWith(hasPopUp: false, retry: getFavorites)), (r) {
      if (r.isEmpty) return;
      getInitialCryptos(r);
    });
  }

  Future<void> updateFavoritesAfterRemoved(String idRemoved) async {
    final response = await _crypto.getFavorites();
    response.fold(
      (l) => CoreSnackBarSuccess.showSnackBarError(text: l.msg),
      (r) =>
          update(state.copyWith(favorites: r, cryptos: (state.cryptos ?? []).where((e) => e.id != idRemoved).toList())),
    );
  }

  Future<void> getInitialCryptos(List<Map> ids) async {
    setLoading(true);
    final response = await _crypto.getCryptos(
      limit: state.limit,
      offset: 0,
      idsToSearch: ids.map((e) => e["id"] as String).toList(),
    );
    setLoading(false);
    response.fold((e) => setError(e.copyWith(hasPopUp: false, retry: () => getInitialCryptos(ids))), (r) {
      update(state.copyWith(cryptos: r, actualPage: 0, favorites: ids));
    });
  }

  onTapFavoriteCrypto(CryptoAssetEntity value) async {
    final response = await _crypto.deleteFavorite(value.id ?? "");
    return response.fold((l) => CoreSnackBarSuccess.showSnackBarError(text: l.msg), (r) {
      CoreSnackBarSuccess.showSnackBarSuccess(text: "${value.name ?? ""} foi removida dos favoritos com sucesso");
      return updateFavoritesAfterRemoved(value.id ?? "");
    });
  }

  onTapNext() async {
    if ((state.cryptos ?? []).length < state.limit) return;
    setLoading(true);
    var offset = (state.actualPage) + 1;
    final response = await _crypto.getCryptos(
      limit: state.limit,
      offset: offset,
      idsToSearch: state.favorites?.map((e) => e["id"] as String).toList(),
    );

    setLoading(false);
    response.fold(
      (e) => setError(e.copyWith(hasPopUp: true, retry: onTapNext)),
      (r) => update(state.copyWith(cryptos: r, actualPage: offset)),
    );
  }

  onTapPrev() async {
    if (state.actualPage == 0) return;

    setLoading(true);
    var offset = (state.actualPage) - 1;
    final response = await _crypto.getCryptos(
      limit: state.limit,
      offset: offset,
      idsToSearch: state.favorites?.map((e) => e["id"] as String).toList(),
    );

    setLoading(false);
    response.fold(
      (e) => setError(e.copyWith(hasPopUp: true, retry: onTapNext)),
      (r) => update(state.copyWith(cryptos: r, actualPage: offset)),
    );
  }
}
