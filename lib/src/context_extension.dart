import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'lifecycle_mixin.dart';
import 'provider_state_builder.dart';

extension ContextExtension on BuildContext {
  Future<T?> showStateDialog<T extends Object?, S extends LifecycleMixin>({
    required Widget child,
    required S Function(BuildContext context) create,
    bool barrierDismissible = false,
    String? barrierLabel,
    Color barrierColor = const Color(0x80000000),
    Duration transitionDuration = const Duration(milliseconds: 200),
    RouteTransitionsBuilder? transitionBuilder,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    Offset? anchorPoint,
  }) {
    return showGeneralDialog<T>(
        context: this,
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return ProviderStateBuilder<S>(create: create, child: child);
        },
        barrierDismissible: barrierDismissible,
        barrierLabel: barrierLabel,
        barrierColor: barrierColor,
        transitionDuration: transitionDuration,
        transitionBuilder: transitionBuilder,
        useRootNavigator: useRootNavigator,
        routeSettings: routeSettings,
        anchorPoint: anchorPoint);
  }

  Future<T?> showStateModalSheet<T extends Object?, S extends LifecycleMixin>({
    required Widget child,
    required S Function(BuildContext context) create,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    BoxConstraints? constraints,
    Color? barrierColor,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    RouteSettings? routeSettings,
    AnimationController? transitionAnimationController,
    Offset? anchorPoint,
  }) {
    return showModalBottomSheet<T>(
        context: this,
        builder: (_) {
          return ProviderStateBuilder<S>(create: create, child: child);
        },
        backgroundColor: backgroundColor,
        elevation: elevation,
        shape: shape,
        clipBehavior: clipBehavior,
        constraints: constraints,
        barrierColor: barrierColor,
        isScrollControlled: isScrollControlled,
        useRootNavigator: useRootNavigator,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        routeSettings: routeSettings,
        transitionAnimationController: transitionAnimationController,
        anchorPoint: anchorPoint);
  }

  T readC<T>() {
    return Provider.of<T>(this, listen: false);
  }
}
