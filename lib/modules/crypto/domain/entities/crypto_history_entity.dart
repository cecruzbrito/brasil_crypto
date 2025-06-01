// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/mixin/date_mixin.dart';
import '../../../../core/mixin/num_mixin.dart';

class CryptoHistoryIntervalEntity {
  final HistoryInterval interval;
  final List<CryptoHistoryEntity>? history;
  CryptoHistoryIntervalEntity({required this.interval, this.history});
}

class CryptoHistoryEntity with NumMixin, DateMixin {
  final String? priceUsd;
  final String? date;
  final String? circulatingSupply;
  CryptoHistoryEntity({required this.priceUsd, required this.date, required this.circulatingSupply});

  double getPrice() => parseDouble(priceUsd);

  DateTime getDate() {
    final result = parseDate(date ?? "");
    return result;
  }
}

enum HistoryInterval {
  m1,
  m5,
  m15,
  m30,
  h1,
  h2,
  h6,
  h12,
  d1;

  DateTimeIntervalType get getIntervalType {
    return switch (this) {
      HistoryInterval.m1 ||
      HistoryInterval.m5 ||
      HistoryInterval.m15 ||
      HistoryInterval.m30 => DateTimeIntervalType.minutes,
      HistoryInterval.h1 ||
      HistoryInterval.h2 ||
      HistoryInterval.h6 ||
      HistoryInterval.h12 => DateTimeIntervalType.hours,
      HistoryInterval.d1 => DateTimeIntervalType.days,
    };
  }

  DateFormat get getDateFormat {
    return switch (this) {
      HistoryInterval.m1 ||
      HistoryInterval.m5 ||
      HistoryInterval.m15 ||
      HistoryInterval.m30 => DateFormat.Hm(), // "20:44"
      HistoryInterval.h1 ||
      HistoryInterval.h2 ||
      HistoryInterval.h6 ||
      HistoryInterval.h12 => DateFormat("dd/MM - HH:mm", 'pt_BR'),
      HistoryInterval.d1 => DateFormat('dd/MM', 'pt_BR'),
    };
  }

  String get id => switch (this) {
    HistoryInterval.m1 => 'm1',
    HistoryInterval.m5 => 'm5',
    HistoryInterval.m15 => 'm15',
    HistoryInterval.m30 => 'm30',
    HistoryInterval.h1 => 'h1',
    HistoryInterval.h2 => 'h2',
    HistoryInterval.h6 => 'h6',
    HistoryInterval.h12 => 'h12',
    HistoryInterval.d1 => 'd1',
  };

  String get label => switch (this) {
    HistoryInterval.m1 => '1 min',
    HistoryInterval.m5 => '5 min',
    HistoryInterval.m15 => '15 min',
    HistoryInterval.m30 => '30 min',
    HistoryInterval.h1 => '1h',
    HistoryInterval.h2 => '2h',
    HistoryInterval.h6 => '6h',
    HistoryInterval.h12 => '12h',
    HistoryInterval.d1 => '1 dia',
  };
}
