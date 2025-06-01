// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:brasilcripto/core/widgets/scroll/core_scroll.dart';
import 'package:brasilcripto/modules/crypto/domain/entities/crypto_asset_entity.dart';

import '../../../domain/entities/crypto_history_entity.dart';

class HistoryChart extends StatefulWidget {
  const HistoryChart({super.key, this.history, required this.actualValue, required this.crypto});
  final CryptoHistoryIntervalEntity? history;
  final HistoryInterval actualValue;
  final CryptoAssetEntity crypto;

  @override
  State<HistoryChart> createState() => _HistoryChartState();
}

class _HistoryChartState extends State<HistoryChart> {
  CryptoAssetEntity get crypto => widget.crypto;
  HistoryInterval get actualValue => widget.actualValue;
  CryptoHistoryIntervalEntity? get history => widget.history;
  List<CryptoHistoryEntity> get list => ((history?.history) ?? []);
  List<_ChartData> get data =>
      list
          .where((e) => e.priceUsd != null && e.date != null)
          .map((e) => _ChartData(e.getDate(), e.getPrice()))
          .toList();

  @override
  Widget build(BuildContext context) {
    final symbol = crypto.symbol ?? "";
    final title = "${crypto.name ?? ""} ($symbol)";
    if (history == null) return Container();
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: CoreScroll(
            direction: Axis.horizontal,
            child: SfCartesianChart(
              title: ChartTitle(text: title, alignment: ChartAlignment.near),
              tooltipBehavior: TooltipBehavior(
                enable: true,
                format: 'Data: point.x\nPreço: \$point.y',
                canShowMarker: true,
              ),
              zoomPanBehavior: ZoomPanBehavior(
                enableDoubleTapZooming: true,
                enablePinching: true,
                enablePanning: true,
                zoomMode: ZoomMode.xy,
                enableMouseWheelZooming: true, // se for para web/desktop
              ),
              backgroundColor: Theme.of(context).cardColor,
              primaryXAxis: DateTimeAxis(
                intervalType: actualValue.getIntervalType,
                desiredIntervals: 4,
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                dateFormat: actualValue.getDateFormat,
              ),
              primaryYAxis: NumericAxis(numberFormat: NumberFormat.compactCurrency(symbol: "", locale: 'pt_BR')),
              series: [
                LineSeries<_ChartData, DateTime>(
                  dataSource: data,
                  xValueMapper: (datum, _) => datum.date,
                  yValueMapper: (datum, _) => datum.price,
                  // dataLabelSettings: const DataLabelSettings(isVisible: false),
                  enableTooltip: true,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ChartData {
  final DateTime date;
  final double price;

  _ChartData(this.date, this.price);
}
