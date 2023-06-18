import 'package:flutter/material.dart';
import 'package:lq_state_lifecycle/lq_state_lifecycle.dart';
import 'package:provider/provider.dart';

import 'lifecycle_mixin.dart';
import 'lifecycle_observer_widget.dart';

class ProxyNotifyBuilder<A extends LifecycleMixin, B extends LifecycleMixin>
    extends StatelessWidget {
  final Widget child;
  final int? pageIndex;
  final A Function(BuildContext context) create1;
  final B Function(BuildContext context) create2;
  final ProxyProviderBuilder<A, B> update;
  final void Function(BuildContext context, A controllerA, B controllerB)?
      onAppear;
  final void Function(BuildContext context, A controllerA, B controllerB)?
      onDisappear;

  const ProxyNotifyBuilder({
    Key? key,
    this.pageIndex,
    required this.create1,
    required this.create2,
    required this.child,
    required this.update,
    this.onAppear,
    this.onDisappear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: create1),
        ChangeNotifierProxyProvider(create: create2, update: update),
      ],
      child: Builder(builder: (cxt) {
        final lifecycleWidget = LifecycleObserverWidget(
          pageIndex: pageIndex,
          onAppear: () {
            final controllerA = cxt.read<A>();
            final controllerB = cxt.read<B>();
            onAppear?.call(cxt, controllerA, controllerB);
          },
          onDisappear: () {
            final controllerA = cxt.read<A>();
            final controllerB = cxt.read<B>();
            onDisappear?.call(cxt, controllerA, controllerB);
          },
          routeInfoCallback: (routeName, arguments) {
            cxt.read<A>().setupArguments(routeName, arguments, pageIndex);
            cxt.read<B>().setupArguments(routeName, arguments, pageIndex);
          },
          indexChanged: (from, to) {
            cxt.read<A>().onPageIndexChanged(from, to);
            cxt.read<B>().onPageIndexChanged(from, to);
          },
          stateChanged: (LifecycleState state) {
            cxt.read<A>().onLifecycleChanged(state);
            cxt.read<B>().onLifecycleChanged(state);
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
