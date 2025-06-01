import 'package:brasilcripto/modules/crypto/domain/repository/crypto_repository.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../domain/entities/crypto_history_entity.dart';
import 'crypto_details_state.dart';

class CryptoDetailsStore extends Store<CryptoDetailsState> {
  final CryptoRepository _crypto;
  CryptoDetailsStore(this._crypto) : super(CryptoDetailsState.initialState);

  getHistory(String idCrypto) async {
    setLoading(true);
    final response = await _crypto.getHistory(idCrypto, interval: state.interval);
    setLoading(false);

    response.fold(
      (l) => setError(l.copyWith(hasPopUp: false, retry: () => getHistory(idCrypto))),
      (r) => update(state.copyWith(history: r)),
    );
  }

  onTapInterval(String idCrypto, HistoryInterval value) async {
    final interval = value;

    setLoading(true);
    final response = await _crypto.getHistory(idCrypto, interval: state.interval);
    setLoading(false);
    response.fold(
      (l) => setError(l.copyWith(hasPopUp: true)),
      (r) => update(state.copyWith(history: r, interval: interval)),
    );
  }
}
