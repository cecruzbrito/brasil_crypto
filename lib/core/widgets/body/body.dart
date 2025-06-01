import 'package:flutter/cupertino.dart';

class BodyWidget extends StatelessWidget {
  const BodyWidget({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10), child: child);
  }
}
