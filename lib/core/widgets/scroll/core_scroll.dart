import 'package:flutter/cupertino.dart';

class CoreScroll extends StatelessWidget {
  const CoreScroll({super.key, required this.child, this.padding, this.direction = Axis.vertical});
  final Widget child;
  final EdgeInsets? padding;
  final Axis direction;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(padding: padding, scrollDirection: direction, child: child);
  }
}
