// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:brasilcripto/modules/crypto/domain/entities/crypto_asset_entity.dart';

import '../../../../../core/widgets/card/core_card.dart';

class InfoCryptoWidget extends StatelessWidget {
  const InfoCryptoWidget({super.key, required this.crypto});
  final CryptoAssetEntity crypto;

  @override
  Widget build(BuildContext context) {
    final priceUsc = crypto.getPrice();

    final supplyTitle = "Oferta em circulação";
    final supply = crypto.getSuply();

    final titleMarketCapUsd = "Valor de mercado";
    final markedcapUsd = crypto.getMarketCapUsd();

    final changePercent24Hr = crypto.getChangePercent24Hr();

    final titleVolumeUsd24Hr = "Volume (24h)";
    final volumeUsd24Hr = crypto.getVolumeUsd24Hr();

    titleAndSubtitle(String title, {required String subtitle}) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 5,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.normal),
        ),
        Text(
          subtitle,
          textAlign: TextAlign.center,

          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: subtitle.contains("-") ? Colors.red : Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
      ],
    );
    return Column(
      spacing: 20,
      children: [
        CoreCard(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10,
                        children: [
                          Text(
                            priceUsc,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                          ),
                          Text(
                            changePercent24Hr,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color:
                                  changePercent24Hr.contains("-")
                                      ? Colors.red
                                      : Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.paid, size: 40),
                  ],
                ),

                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(child: titleAndSubtitle(titleVolumeUsd24Hr, subtitle: volumeUsd24Hr)),
                      VerticalDivider(),
                      Expanded(child: titleAndSubtitle(titleMarketCapUsd, subtitle: markedcapUsd)),
                      VerticalDivider(),

                      Expanded(child: titleAndSubtitle(supplyTitle, subtitle: supply)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
