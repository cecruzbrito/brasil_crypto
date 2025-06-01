// ignore_for_file: public_member_api_docs, sort_constructors_first
class Failure implements Exception {
  final String msg;
  Function()? retry;
  final bool hasPopUp;
  Failure({required this.msg, this.retry, this.hasPopUp = true});

  void setRetry(Function()? value) => retry = value;

  Failure copyWith({String? msg, Function()? retry, bool? hasPopUp}) {
    return Failure(msg: msg ?? this.msg, retry: retry ?? this.retry, hasPopUp: hasPopUp ?? this.hasPopUp);
  }
}
