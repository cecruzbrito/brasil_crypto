// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brasilcripto/core/widgets/scroll/core_scroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../domain/entities/crypto_history_entity.dart';

class HeaderFilterChart extends StatelessWidget {
  const HeaderFilterChart({super.key, required this.onTapInterval, required this.actualValue});
  final Function(HistoryInterval) onTapInterval;
  final HistoryInterval actualValue;
  @override
  Widget build(BuildContext context) {
    return CoreScroll(
      direction: Axis.horizontal,
      child: Row(
        spacing: 5,
        children:
            HistoryInterval.values.map((e) {
              var hasSelected = e == actualValue;
              if (hasSelected) {
                return FilledButton(onPressed: () => onTapInterval(e), child: Text(e.label));
              }
              return OutlinedButton(onPressed: () => onTapInterval(e), child: Text(e.label));
            }).toList(),
      ),
    );
  }
}
