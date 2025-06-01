// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';

import '../../../../core/mixin/forms_validator/forms_validator.dart';
import '../../../../core/widgets/text_fields/default/core_text_field_default.dart';

class SearchHeader extends StatelessWidget with FormsValidator {
  const SearchHeader({
    super.key,
    required this.ctrSearch,
    required this.forms,
    required this.onTapSearch,
    required this.onTapClear,
    required this.onTapClearFilter,
    required this.lastSearch,
  });
  final TextEditingController ctrSearch;
  final GlobalKey<FormState> forms;
  final Function() onTapSearch;
  final Function() onTapClear;
  final Function() onTapClearFilter;
  final String? lastSearch;
  @override
  Widget build(BuildContext context) {
    final search = lastSearch ?? "";
    return Column(
      spacing: 15,
      children: [
        Form(
          key: forms,
          child: Row(
            spacing: 5,
            children: [
              Expanded(
                child: CoreTextFieldDefault(
                  label: "Pesquisar",
                  ctr: ctrSearch,
                  validator: emptyValidator,
                  onTapEnter: (p0) => onTapSearch(),
                  prefix: Icon(Icons.search),
                  suffix: IconButton(onPressed: onTapClear, icon: Icon(Icons.close)),
                ),
              ),

              IconButton.filledTonal(onPressed: onTapSearch, icon: Icon(Icons.search)),
            ],
          ),
        ),
        if (search.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: RichText(
                  text: TextSpan(
                    text: "Mostrando resultados para ",
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: search,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontStyle: FontStyle.italic,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              OutlinedButton.icon(icon: Icon(Icons.clear), onPressed: onTapClearFilter, label: Text("Limpar")),
            ],
          ),
      ],
    );
  }
}
