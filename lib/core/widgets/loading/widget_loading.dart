import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../card/core_card.dart';

class WidgetLoading extends StatelessWidget {
  const WidgetLoading({super.key, required this.hasLoadingCard});
  final bool hasLoadingCard;
  @override
  Widget build(BuildContext context) {
    if (hasLoadingCard) {
      return CoreCard(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),

          child: SizedBox(
            width: double.infinity,
            child: Column(
              spacing: 10,
              mainAxisSize: MainAxisSize.min,
              children: [CircularProgressIndicator(), Text("Aguarde...")],
            ),
          ),
        ),
      );
    }
    return Center(
      child: Column(
        spacing: 10,
        mainAxisSize: MainAxisSize.min,
        children: [CircularProgressIndicator(), Text("Aguarde...")],
      ),
    );
  }
}
