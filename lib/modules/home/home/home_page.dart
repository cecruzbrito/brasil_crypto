import 'package:brasilcripto/core/services/navigation/service_navigation.dart';
import 'package:brasilcripto/modules/home/home/widgets/item_crypto.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../core/widgets/body/body.dart';
import '../../../core/widgets/builder/builder_widget.dart';
import '../../../core/widgets/scroll/core_scroll.dart';
import '../../../core/widgets/scroll/core_scroll_pull_refresh.dart';
import '../../../core/widgets/text_fields/default/core_text_field_default.dart';
import 'store/home_store.dart';
import 'widgets/list_itens_crypto.dart';
import 'widgets/pagination_crypto.dart';
import 'widgets/search_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.store});
  final HomeStore store;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeStore get store => widget.store;
  final refreshControler = RefreshController();

  @override
  void initState() {
    super.initState();
    store.initializing();
    ServiceNavigation.addListener(store.getFavorites);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Página Inicial")),
      body: BuilderWidget(
        store: store,
        child:
            (_, state) => CoreScrollPullRefresh(
              onReload: () async {
                await store.initializing();
                refreshControler.loadComplete();
              },
              child: CoreScroll(
                child: BodyWidget(
                  child: Column(
                    spacing: 15,
                    children: [
                      SearchHeader(
                        onTapClearFilter: store.onTapClearFilter,
                        lastSearch: state.lastSearch,
                        forms: store.forms,
                        ctrSearch: store.ctrSearch,
                        onTapClear: store.onTapClear,
                        onTapSearch: store.onTapSearch,
                      ),
                      ListItensCrypto(
                        cryptos: state.cryptos,
                        onTapFavoriteCrypto: store.onTapFavoriteCrypto,
                        favorites: state.favorites,
                      ),
                      PaginationCrypto(
                        lengthResult: (state.cryptos ?? []).length,
                        limit: state.limit,
                        actualPage: state.actualPage,
                        onTapNext: store.onTapNext,
                        onTapPrev: store.onTapPrev,
                      ),
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
