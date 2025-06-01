import 'package:brasilcripto/core/widgets/scroll/core_scroll.dart';
import 'package:brasilcripto/modules/crypto/domain/entities/crypto_asset_entity.dart';
import 'package:brasilcripto/modules/crypto/presentation/details/widgets/header_filter_chart.dart';
import 'package:brasilcripto/modules/crypto/presentation/details/widgets/info_crypto.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/body/body.dart';
import '../../../../core/widgets/builder/builder_widget.dart';
import '../../../../core/widgets/card/core_card.dart';
import 'store/crypto_details_store.dart';
import 'widgets/history_chart.dart';

class CryptoDetailsPage extends StatefulWidget {
  const CryptoDetailsPage({super.key, required this.crypto, required this.store});
  final CryptoAssetEntity crypto;
  final CryptoDetailsStore store;
  @override
  State<CryptoDetailsPage> createState() => _CryptoDetailsPageState();
}

class _CryptoDetailsPageState extends State<CryptoDetailsPage> {
  CryptoDetailsStore get store => widget.store;
  CryptoAssetEntity get crypto => widget.crypto;

  @override
  void initState() {
    super.initState();
    store.getHistory(crypto.id ?? "");
  }

  @override
  Widget build(BuildContext context) {
    final symbol = crypto.symbol ?? "";
    final title = "${crypto.name ?? ""} ($symbol)";
    return Scaffold(
      appBar: AppBar(title: Text(title)),

      body: BodyWidget(
        child: CoreScroll(
          child: Column(
            spacing: 10,
            children: [
              InfoCryptoWidget(crypto: crypto),

              BuilderWidget(
                store: store,
                hasLoadingCard: true,
                child:
                    (_, state) => Column(
                      children: [
                        CoreCard(
                          child: HeaderFilterChart(
                            actualValue: state.interval,
                            onTapInterval: (interval) => store.onTapInterval(crypto.id ?? "", interval),
                          ),
                        ),
                        CoreCard(
                          child: HistoryChart(history: state.history, actualValue: state.interval, crypto: crypto),
                        ),
                      ],
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
