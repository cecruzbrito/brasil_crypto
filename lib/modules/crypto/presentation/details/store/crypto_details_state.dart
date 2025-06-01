// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../domain/entities/crypto_history_entity.dart';

class CryptoDetailsState {
  final CryptoHistoryIntervalEntity? history;
  final HistoryInterval interval;

  CryptoDetailsState({this.history, this.interval = HistoryInterval.m1});

  static final initialState = CryptoDetailsState();

  CryptoDetailsState copyWith({CryptoHistoryIntervalEntity? history, HistoryInterval? interval}) {
    return CryptoDetailsState(history: history ?? this.history, interval: interval ?? this.interval);
  }
}
