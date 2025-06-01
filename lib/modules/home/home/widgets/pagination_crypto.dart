// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class PaginationCrypto extends StatelessWidget {
  const PaginationCrypto({
    super.key,
    required this.onTapPrev,
    required this.onTapNext,
    required this.actualPage,
    required this.limit,
    required this.lengthResult,
  });
  final Function() onTapPrev;
  final Function() onTapNext;
  final int actualPage;
  final int limit;
  final int lengthResult;
  @override
  Widget build(BuildContext context) {
    if (lengthResult == 0) return Container();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FilledButton.icon(
          onPressed: actualPage == 0 ? null : onTapPrev,
          label: Text("Anterior"),
          icon: Icon(Icons.arrow_back_ios),
        ),
        FilledButton.icon(
          onPressed: lengthResult < limit ? null : onTapNext,
          iconAlignment: IconAlignment.end,
          label: Text("Próxima"),
          icon: Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }
}
