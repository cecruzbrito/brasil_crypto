import 'package:brasilcripto/core/services/navigation/service_navigation.dart';
import 'package:brasilcripto/core/widgets/body/body.dart';
import 'package:brasilcripto/core/widgets/scroll/core_scroll.dart';
import 'package:brasilcripto/modules/home/home/widgets/list_itens_crypto.dart';
import 'package:brasilcripto/modules/home/home/widgets/pagination_crypto.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/builder/builder_widget.dart';
import 'store/favorites_store.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key, required this.store});
  final FavoritesStore store;
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  FavoritesStore get store => widget.store;

  @override
  void initState() {
    super.initState();
    store.getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favoritos")),
      body: BodyWidget(
        child: BuilderWidget(
          store: store,
          child: (_, state) {
            if ((state.favorites ?? []).isEmpty) {
              return Center(
                child: Column(
                  spacing: 5,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Icon(Icons.favorite_border), Text('Sua lista de criptomoedas favoritas está vazia.')],
                ),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: CoreScroll(
                    child: ListItensCrypto(
                      onTapFavoriteCrypto: store.onTapFavoriteCrypto,
                      cryptos: state.cryptos,
                      favorites: state.favorites,
                    ),
                  ),
                ),
                PaginationCrypto(
                  onTapPrev: store.onTapPrev,
                  onTapNext: store.onTapNext,
                  actualPage: state.actualPage,
                  limit: state.limit,
                  lengthResult: (state.favorites ??[ ]).length,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
