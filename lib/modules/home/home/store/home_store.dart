import 'package:brasilcripto/modules/crypto/domain/entities/crypto_asset_entity.dart';
import 'package:brasilcripto/modules/crypto/domain/repository/crypto_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../../core/widgets/snack_bars/core_snack_bar_success.dart';
import 'home_state.dart';

class HomeStore extends Store<HomeState> {
  final CryptoRepository _crypto;
  HomeStore(this._crypto) : super(HomeState.initialState);
  final ctrSearch = TextEditingController();
  final forms = GlobalKey<FormState>();

  initializing() async {
    await getInitialCryptos();
  }

  Future<void> getInitialCryptos() async {
    setLoading(true);
    final response = await _crypto.getCryptos(limit: state.limit, offset: 0);
    setLoading(false);
    response.fold((e) => setError(e.copyWith(hasPopUp: false, retry: getInitialCryptos)), (r) async {
      ctrSearch.clear();
      update(state.copyWith(cryptos: r, actualPage: 0, lastSearch: ""));
      await getFavorites();
    });
  }

  onTapNext() async {
    if ((state.cryptos ?? []).length < state.limit) return;
    setLoading(true);
    var offset = (state.actualPage) + 1;
    final response = await _crypto.getCryptos(limit: state.limit, offset: offset);

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
    final response = await _crypto.getCryptos(limit: state.limit, offset: offset);

    setLoading(false);
    response.fold(
      (e) => setError(e.copyWith(hasPopUp: true, retry: onTapNext)),
      (r) => update(state.copyWith(cryptos: r, actualPage: offset)),
    );
  }

  onTapClear() {
    ctrSearch.clear();
  }

  onTapSearch() async {
    if (forms.currentState == null) return;
    if (!forms.currentState!.validate()) return;
    setLoading(true);
    final offset = 0;
    final search = ctrSearch.text;
    final response = await _crypto.getCryptos(limit: state.limit, offset: offset, search: search);

    setLoading(false);
    response.fold(
      (e) => setError(e.copyWith(hasPopUp: true, retry: onTapNext)),
      (r) => update(state.copyWith(cryptos: r, actualPage: offset, lastSearch: search)),
    );
  }

  onTapClearFilter() async => await getInitialCryptos();

  Future<void> getFavorites() async {
    final response = await _crypto.getFavorites();
    return response.fold(
      (l) => CoreSnackBarSuccess.showSnackBarError(text: l.msg),
      (r) => update(state.copyWith(favorites: r)),
    );
  }

  onTapFavoriteCrypto(CryptoAssetEntity value) async {
    if ((state.favorites ?? []).any((f) => f["id"] == value.id)) {
      final response = await _crypto.deleteFavorite(value.id ?? "");
      return response.fold((l) => CoreSnackBarSuccess.showSnackBarError(text: l.msg), (r) {
        CoreSnackBarSuccess.showSnackBarSuccess(text: "${value.name ?? ""} foi removida dos favoritos com sucesso");
        return getFavorites();
      });
    }
    final response = await _crypto.setFavorite(value.id ?? "");
    return response.fold((l) => CoreSnackBarSuccess.showSnackBarError(text: l.msg), (r) {
      CoreSnackBarSuccess.showSnackBarSuccess(text: "${value.name ?? ""} foi adicionada aos favoritos com sucesso");
      return getFavorites();
    });
  }
}
