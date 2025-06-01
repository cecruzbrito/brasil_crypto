import 'package:intl/intl.dart';

mixin DateMixin {
  DateTime parseDate(String value) => DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parseUtc(value);
}
