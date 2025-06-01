// ignore_for_file: public_member_api_docs, sort_constructors_first
class NavigationBarRouteState {
  final int actualIndex;
  NavigationBarRouteState({this.actualIndex = 0});
  static final initialState = NavigationBarRouteState();

  NavigationBarRouteState copyWith({int? actualIndex}) {
    return NavigationBarRouteState(actualIndex: actualIndex ?? this.actualIndex);
  }
}
