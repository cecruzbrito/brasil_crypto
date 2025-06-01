import 'package:flutter_triple/flutter_triple.dart';

import '../../../../../core/services/navigation/service_navigation.dart';
import 'navigation_bar_route_state.dart';

class NavigationBarRouteStore extends Store<NavigationBarRouteState> {
  NavigationBarRouteStore() : super(NavigationBarRouteState.initialState);

  initializing() {
    getPage();
    ServiceNavigation.addListener(getPage);
  }

  getPage() {
    final page = ServiceNavigation.getPage();
    update(state.copyWith(actualIndex: page.contains("initial_page") ? 0 : 1));
  }
}
