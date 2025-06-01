// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:brasilcripto/modules/crypto/domain/entities/crypto_asset_entity.dart';

import 'item_crypto.dart';

class ListItensCrypto extends StatelessWidget {
  const ListItensCrypto({super.key, required this.cryptos, required this.onTapFavoriteCrypto, required this.favorites});
  final List<CryptoAssetEntity>? cryptos;
  final Function(CryptoAssetEntity) onTapFavoriteCrypto;
  final List<Map>? favorites;

  @override
  Widget build(BuildContext context) {
    if ((cryptos ?? []).isEmpty) {
      return Column(children: [Icon(Icons.search_off), Text("Nenhuma criptomoeda encontrada")]);
    }

    return Column(
      spacing: 5,
      children: [
        ...(cryptos ?? []).map(
          (e) => ItemCrypto(
            crypto: e,
            onTapFavoriteCrypto: onTapFavoriteCrypto,
            hasFavorite: (favorites ?? []).any((f) => f["id"] == e.id),
          ),
        ),
      ],
    );
  }
}
