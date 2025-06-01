import 'package:flutter_modular/flutter_modular.dart';

import '../core/core_module.dart';
import 'splash/splash_page.dart';

class SplashModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(RouteManager r) {
    super.routes(r);

    r.child(Modular.initialRoute, child: (_) => SpashPage());
  }
}
