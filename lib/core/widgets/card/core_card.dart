// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CoreCard extends StatelessWidget {
  const CoreCard({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Card(child: Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20), child: child));
  }
}
