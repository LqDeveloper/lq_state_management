import 'package:flutter/material.dart';
import 'package:lq_state_lifecycle/lq_state_lifecycle.dart';
import 'package:provider/provider.dart';

import 'lifecycle_mixin.dart';
import 'lifecycle_observer_widget.dart';

class ProviderStateBuilder<T extends LifecycleMixin> extends StatelessWidget {
  final Widget child;
  final T? value;
  final T Function(BuildContext context)? create;
  final int? pageIndex;
  final void Function(BuildContext context, T controller)? onAppear;
  final void Function(BuildContext context, T controller)? onDisappear;

  const ProviderStateBuilder({
    Key? key,
    this.pageIndex,
    this.value,
    this.create,
    required this.child,
    this.onAppear,
    this.onDisappear,
  })  : assert(
            (value == null && create != null) ||
                (value != null && create == null),
            'value 和 create只能设置一个'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (create != null) {
      return ChangeNotifierProvider<T>(
        create: create!,
        child: Builder(builder: (cxt) {
          final lifecycleWidget = LifecycleObserverWidget(
            pageIndex: pageIndex,
            onAppear: () {
              final controller = cxt.read<T>();
              onAppear?.call(cxt, controller);
            },
            onDisappear: () {
              final controller = cxt.read<T>();
              onDisappear?.call(cxt, controller);
            },
            routeInfoCallback: (routeName, arguments) {
              cxt.read<T>().setupArguments(routeName, arguments, pageIndex);
            },
            indexChanged: (from, to) {
              cxt.read<T>().onPageIndexChanged(from, to);
            },
            stateChanged: (LifecycleState state) {
              if (state == LifecycleState.onDispose) return;
              cxt.read<T>().onLifecycleChanged(state);
            },
            builder: (BuildContext context) {
              return child;
            },
          );
          return lifecycleWidget;
        }),
      );
    } else {
      return ChangeNotifierProvider<T>.value(
        value: value!,
        child: Builder(builder: (cxt) {
          final lifecycleWidget = LifecycleObserverWidget(
            pageIndex: pageIndex,
            onAppear: () {
              final controller = cxt.read<T>();
              onAppear?.call(cxt, controller);
            },
            onDisappear: () {
              final controller = cxt.read<T>();
              onDisappear?.call(cxt, controller);
            },
            routeInfoCallback: (routeName, arguments) {
              cxt.read<T>().setupArguments(routeName, arguments, pageIndex);
            },
            indexChanged: (from, to) {
              cxt.read<T>().onPageIndexChanged(from, to);
            },
            stateChanged: (LifecycleState state) {
              cxt.read<T>().onLifecycleChanged(state);
            },
            builder: (BuildContext context) {
              return child;
            },
          );
          return lifecycleWidget;
        }),
      );
    }
  }
}
