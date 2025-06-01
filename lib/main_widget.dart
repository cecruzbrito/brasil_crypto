import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import 'core/theme/theme.dart';

class NavKey {
  static final navKey = GlobalKey<NavigatorState>();
}

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  @override
  void initState() {
    super.initState();
    Modular.setNavigatorKey(NavKey.navKey);
  }

  @override
  Widget build(BuildContext context) {
    final customTheme = MaterialTheme(Typography.material2021().black);

    return MaterialApp.router(
      title: "Brasil Cripto",
      routerConfig: Modular.routerConfig,
      localizationsDelegates: const [
        RefreshLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: customTheme.light(),
      darkTheme: customTheme.dark(),
      themeMode: ThemeMode.system,
    );
  }
}
