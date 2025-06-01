import 'package:intl/intl.dart';

mixin StringMixin {
  String formatChangePercent(String? rawPercent) {
    if (rawPercent == null) return "";

    final parsed = double.tryParse(rawPercent);

    if (parsed == null) return "";

    // Arredonda com 2 casas decimais
    final formatted = parsed.toStringAsFixed(2);

    // Adiciona símbolo de porcentagem
    return "$formatted%";
  }

  String formatMoney(String? rawVolume, {String? symbol}) {
    if (rawVolume == null) return "";

    final parsed = double.tryParse(rawVolume);

    if (parsed == null) return "";

    // Define formatação com separador de milhar e 2 casas decimais
    final formatter = NumberFormat.compactCurrency(symbol: symbol, decimalDigits: 2, locale: 'pt_BR');

    return formatter.format(parsed);
  }

  String formatBigNumber(String? value) {
    if (value == null) return "";

    final parsed = double.tryParse(value);
    if (parsed == null) return "";

    return NumberFormat.decimalPattern('pt_BR').format(parsed);
  }
}
