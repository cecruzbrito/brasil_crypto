import 'package:flutter/material.dart';

import '../../../errors/errors.dart';
import '../../../services/navigation/service_navigation.dart';

class CoreAlertError extends StatelessWidget {
  const CoreAlertError({super.key, required this.failure});
  final Failure failure;
  show(BuildContext context) async => await showDialog(context: context, builder: build);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Ocorreu um erro"),
      content: Text(failure.msg),
      actions: [FilledButton(onPressed: ServiceNavigation.pop, child: Text("Ok"))],
    );
  }
}
