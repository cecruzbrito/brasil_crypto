// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brasilcripto/core/errors/errors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../alerts/error/core_alert_error.dart';
import '../error_screen/failure_widget.dart';
import '../loading/widget_loading.dart';

class BuilderWidget<T> extends StatefulWidget {
  const BuilderWidget({super.key, required this.store, required this.child, this.hasLoadingCard = false});
  final BaseStore<T> store;
  final Widget Function(BuildContext, T) child;
  final bool hasLoadingCard;
  @override
  State<BuilderWidget<T>> createState() => _BuilderWidgetState<T>();
}

class _BuilderWidgetState<T> extends State<BuilderWidget<T>> {
  BaseStore get store => widget.store;
  get child => widget.child;
  bool get hasLoadingCard => widget.hasLoadingCard;

  @override
  void initState() {
    super.initState();

    store.observer(
      onError: (e) async {
        final error = e as Failure;
        if (error.hasPopUp) {
          await CoreAlertError(failure: error).show(context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TripleBuilder(
      store: store,
      key: !kDebugMode ? null : UniqueKey(),
      builder: (context, state) {
        if (state.isLoading) return WidgetLoading(hasLoadingCard: hasLoadingCard);
        final error = state.error as Failure?;
        if (error != null && !error.hasPopUp) {
          return FailureWidget(failure: state.error);
        }
        return child(context, state.state as T);
      },
    );
  }
}
