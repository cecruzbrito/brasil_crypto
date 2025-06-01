import 'package:brasilcripto/core/services/navigation/service_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/widgets/builder/builder_widget.dart';
import 'store/navigation_bar_route_store.dart';

class WidgetNavigationBarHomeRouter extends StatefulWidget {
  const WidgetNavigationBarHomeRouter({super.key});

  @override
  State<WidgetNavigationBarHomeRouter> createState() => _WidgetNavigationBarHomeRouterState();
}

class _WidgetNavigationBarHomeRouterState extends State<WidgetNavigationBarHomeRouter> {
  final store = Modular.get<NavigationBarRouteStore>();

  @override
  void initState() {
    super.initState();
    store.initializing();
  }

  @override
  Widget build(BuildContext context) {
    return BuilderWidget(
      store: store,
      child: (_, state) {
        return NavigationBar(
          selectedIndex: state.actualIndex,
          onDestinationSelected: (int value) {
            switch (value) {
              case 0:
                ServiceNavigation.popOrPush("/home/initial_page");
                break;
              case 1:
                ServiceNavigation.popOrPush("/home/favorites");
              default:
            }
          },
          destinations: [
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: "Página inicial",
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.favorite),
              icon: Icon(Icons.favorite_border),
              label: "Favoritos",
            ),
            NavigationDestination(selectedIcon: Icon(Icons.person), icon: Icon(Icons.person_outlined), label: "Perfil"),
          ],
        );
      },
    );
  }
}
