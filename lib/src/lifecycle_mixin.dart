import 'package:flutter/material.dart';
import 'package:lq_state_lifecycle/lq_state_lifecycle.dart';

mixin LifecycleMixin on ChangeNotifier {
  ///当前路由的名字,如："/settings"
  String? _routeName;

  String? get routeName => _routeName;

  ///路由传递过来的参数
  Object? _arguments;

  Object? get arguments => _arguments;

  ///页面的pageIndex
  int? _pageIndex;

  int? get pageIndex => _pageIndex;

  bool _hasAppeared = false;

  ///当前页面是否显示
  bool get hasAppeared => _hasAppeared;

  @mustCallSuper
  void onLifecycleChanged(LifecycleState state) {
    switch (state) {
      case LifecycleState.onInit:
        onInit();
        break;
      case LifecycleState.onContextReady:
        onContextReady();
        break;
      case LifecycleState.onPostFrame:
        onPostFrame();
        break;
      case LifecycleState.onAppear:
        onAppear();
        break;
      case LifecycleState.onDisappear:
        onDisappear();
        break;
      case LifecycleState.onResume:
        onResume();
        break;
      case LifecycleState.onPause:
        onPause();
        break;
      default:
        break;
    }
  }

  ///设置路由传递的参数
  void setupArguments(String? routeName, Object? arguments, int? pageIndex) {
    _routeName = routeName;
    _arguments = arguments;
    _pageIndex = pageIndex;
  }

  ///PageView页面切换
  void onPageIndexChanged(int from, int to) {}

  /// 对应 state 的initState
  @protected
  void onInit() {}


  ///在这个阶段获取路由传参，这个方法走后会走build方法，所以不需要再notify了
  @protected
  void onContextReady(){}

  /// WidgetsBinding.instance.addPostFrameCallback
  @protected
  void onPostFrame() {}

  ///页面显示
  @protected
  @mustCallSuper
  void onAppear() {
    _hasAppeared = true;
  }

  ///页面不显示
  @protected
  @mustCallSuper
  void onDisappear() {
    _hasAppeared = false;
  }

  ///AppLifecycleState.resumed
  /// App从后台进入前台
  @protected
  void onResume() {}

  ///AppLifecycleState.paused
  /// App从前台进入后台
  @protected
  void onPause() {}
}
