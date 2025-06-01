// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class CoreScrollPullRefresh extends StatefulWidget {
  const CoreScrollPullRefresh({super.key, required this.child, required this.onReload});
  final Widget child;
  final Future<void> Function() onReload;
  @override
  State<CoreScrollPullRefresh> createState() => _CoreScrollPullRefreshState();
}

class _CoreScrollPullRefreshState extends State<CoreScrollPullRefresh> {
  final refreshControler = RefreshController();
  Widget get child => widget.child;
  Future<void> Function() get onReload => widget.onReload;

  @override
  void dispose() {
    refreshControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshControler,
      onRefresh: () async {
        await onReload();
        refreshControler.loadComplete();
      },

      child: child,
    );
  }
}
