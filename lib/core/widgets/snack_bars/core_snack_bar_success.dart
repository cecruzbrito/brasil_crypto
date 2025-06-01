// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brasilcripto/main_widget.dart';
import 'package:flutter/material.dart';

class CoreSnackBarSuccess {
  static showSnackBarSuccess({BuildContext? context, String text = "Sucesso!"}) {
    final usingContext = context ?? NavKey.navKey.currentContext;
    if (usingContext == null) return;
    return ScaffoldMessenger.of(usingContext).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Row(spacing: 8, children: [Icon(Icons.check_circle), Flexible(child: Text(text))]),
      ),
    );
  }

  static showSnackBarError({BuildContext? context, String text = "Sucesso!"}) {
    final usingContext = context ?? NavKey.navKey.currentContext;
    if (usingContext == null) return;
    final theme = Theme.of(usingContext);
    return ScaffoldMessenger.of(usingContext).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),

        backgroundColor: theme.colorScheme.error,
        content: Row(
          spacing: 5,
          children: [
            Icon(Icons.check_circle, color: theme.colorScheme.onError),
            Flexible(child: Text(text, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onError))),
          ],
        ),
      ),
    );
  }
}
