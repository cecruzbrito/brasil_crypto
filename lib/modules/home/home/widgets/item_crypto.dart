// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brasilcripto/core/services/navigation/service_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:brasilcripto/modules/crypto/domain/entities/crypto_asset_entity.dart';

class ItemCrypto extends StatelessWidget {
  const ItemCrypto({super.key, required this.crypto, required this.onTapFavoriteCrypto, required this.hasFavorite});
  final CryptoAssetEntity crypto;
  final Function(CryptoAssetEntity) onTapFavoriteCrypto;
  final bool hasFavorite;
  @override
  Widget build(BuildContext context) {
    final rank = crypto.rank == null ? "" : "${crypto.rank}°";
    final symbol = crypto.symbol ?? "";
    final title = "$rank ${crypto.name ?? ""} ($symbol)";
    final priceUsc = "Preço atual: ${crypto.getPrice()}";
    final changePercent24Hr = "Variação (24h): ${crypto.getChangePercent24Hr()}";
    final volumeUsd24Hr = "Volume (24h): ${crypto.getVolumeUsd24Hr()}";

    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        onTap: () {
          ServiceNavigation.push("/crypto_details/", data: {"crypto": crypto});
        },
        isThreeLine: true,
        title: Text(title),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(priceUsc), Text(changePercent24Hr), Text(volumeUsd24Hr)],
        ),
        leading: Icon(Icons.paid),
        trailing: IconButton(
          onPressed: () => onTapFavoriteCrypto(crypto),
          icon: hasFavorite ? Icon(Icons.favorite, color: Colors.red) : Icon(Icons.favorite_border),
        ),
      ),
    );
  }
}
