mixin NumMixin {
  double parseDouble(String? value) {
    if (value == null) return 0;
    return double.tryParse(value) ?? 0;
  }
}
