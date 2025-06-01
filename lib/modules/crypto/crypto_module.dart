import 'package:brasilcripto/core/core_module.dart';
import 'package:brasilcripto/modules/crypto/infra/datasource/crypto_datasource.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repository/crypto_repository.dart';
import 'external/datasource/crypto_datasource_imp.dart';
import 'infra/repository/crypto_repository_imp.dart';
import 'presentation/details/crypto_details_page.dart';
import 'presentation/details/store/crypto_details_store.dart';

class CryptoModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];
  @override
  void binds(Injector i) {
    super.binds(i);
    i.add<CryptoRepository>(CryptoRepositoryImp.new);
    i.add<CryptoDatasource>(CryptoDatasourceImp.new);

    i.add(CryptoDetailsStore.new);
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);

    r.child("/", child: (_) => CryptoDetailsPage(crypto: r.args.data["crypto"], store: Modular.get()));
  }
}
