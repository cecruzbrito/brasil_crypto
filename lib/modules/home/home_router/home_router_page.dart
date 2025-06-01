import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'widgets/navigation_bar_home_router.dart';

class HomeRouterPage extends StatefulWidget {
  const HomeRouterPage({super.key});

  @override
  State<HomeRouterPage> createState() => _HomeRouterPageState();
}

class _HomeRouterPageState extends State<HomeRouterPage> {
  @override
  void initState() {
    super.initState();
    Modular.setInitialRoute("/home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: WidgetNavigationBarHomeRouter(), body: RouterOutlet());
  }
}
