import 'package:brasilcripto/core/errors/errors.dart';
import 'package:flutter/material.dart';

class FailureWidget extends StatelessWidget {
  final Failure failure;
  const FailureWidget({super.key, required this.failure});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.error, color: Theme.of(context).colorScheme.error, size: 50),
          Text(failure.msg),
          if (failure.retry != null)
            OutlinedButton.icon(icon: Icon(Icons.refresh), onPressed: failure.retry, label: Text("Tentar novamente")),
        ],
      ),
    );
  }
}
