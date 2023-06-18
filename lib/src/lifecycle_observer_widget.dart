import 'package:flutter/material.dart';
import 'package:lq_state_lifecycle/lq_state_lifecycle.dart';

class LifecycleObserverWidget extends StatefulWidget {
  final WidgetBuilder builder;
  final int? pageIndex;
  final void Function(LifecycleState state)? stateChanged;
  final void Function(String? routeName, Object? arguments)? routeInfoCallback;
  final void Function(int from, int to)? indexChanged;
  final VoidCallback? onAppear;
  final VoidCallback? onDisappear;

  const LifecycleObserverWidget({
    Key? key,
    required this.builder,
    required this.stateChanged,
    required this.routeInfoCallback,
    required this.pageIndex,
    this.onAppear,
    this.onDisappear,
    this.indexChanged,
  }) : super(key: key);

  @override
  State<LifecycleObserverWidget> createState() =>
      _LifecycleObserverWidgetState();
}

class _LifecycleObserverWidgetState extends State<LifecycleObserverWidget>
    with StateLifecycleMixin {
  @override
  int get pageIndex => widget.pageIndex ?? -1;

  @override
  void onContextReady() {
    super.onContextReady();
    final RouteSettings? settings = ModalRoute.of(context)?.settings;
    widget.routeInfoCallback?.call(settings?.name, settings?.arguments);
  }

  @override
  void onAppear() {
    super.onAppear();
    widget.onAppear?.call();
  }

  @override
  void onDisappear() {
    super.onDisappear();
    widget.onDisappear?.call();
  }

  @override
  void onLifecycleStateChanged(LifecycleState state) {
    widget.stateChanged?.call(state);
  }

  @override
  void onPageViewChanged(int from, int to) {
    widget.indexChanged?.call(from, to);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
