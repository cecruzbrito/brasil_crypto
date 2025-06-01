import 'package:brasilcripto/modules/crypto/crypto_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'favorites/favorites_page.dart' show FavoritesPage;
import 'favorites/store/favorites_store.dart';
import 'home/home_page.dart';
import 'home/store/home_store.dart';
import 'home_router/home_router_page.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [CryptoModule()];

  @override
  void binds(Injector i) {
    super.binds(i);
    i.add(HomeStore.new);
    i.add(FavoritesStore.new);
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);

    r.child(
      Modular.initialRoute,
      child: (_) => HomeRouterPage(),
      children: [
        ChildRoute("/initial_page", transition: TransitionType.fadeIn, child: (_) => HomePage(store: Modular.get())),
        ChildRoute(
          "/favorites",
          transition: TransitionType.rightToLeft,

          child: (_) => FavoritesPage(store: Modular.get()),
        ),
      ],
    );
  }
}
