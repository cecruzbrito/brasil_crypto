import 'package:flutter_modular/flutter_modular.dart';

class ServiceNavigation {
  static String getPage() => Modular.to.path;

  static void addListener(void Function() listener) => Modular.to.addListener(listener);

  static pop([dynamic value]) => Modular.to.pop(value);

  static nav(String route) => Modular.to.navigate(route);

  static Future<T?> push<T>(String route, {dynamic data}) async =>
      await Modular.to.pushNamed<T>(route, arguments: data);

  static Future<void> popUntil(String route) async => await Modular.to.pushNamedAndRemoveUntil(route, (p0) => false);

  static popAndGo(String route, {dynamic data}) async => await Modular.to.popAndPushNamed(route, arguments: data);

  static popOrPush(String routeName) async {
    final currentStack = Modular.to.navigateHistory.map((e) => e.name);

    // Verifica se a rota já está no histórico
    if (currentStack.any((r) => r == routeName)) {
      // Volta até a rota
      return await popUntil(routeName);
    }

    await push(routeName);
  }
}
