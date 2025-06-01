import 'package:flutter_modular/flutter_modular.dart';

import 'modules/crypto/crypto_module.dart';
import 'modules/home/home_module.dart';
import 'modules/home/home_router/widgets/store/navigation_bar_route_store.dart';
import 'modules/splash_module.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    super.binds(i);
    i.add(NavigationBarRouteStore.new);
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.add(ModuleRoute(Modular.initialRoute, module: SplashModule()));
    r.add(ModuleRoute("/home", module: HomeModule()));
    r.add(ModuleRoute("/crypto_details", module: CryptoModule()));
  }
}
