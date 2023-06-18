import 'dart:async';

import 'package:flutter/material.dart';

import 'event_bus.dart';

class _EventBusInstance {
  static final _EventBusInstance _instance = _EventBusInstance._internal();

  factory _EventBusInstance() {
    return _instance;
  }

  _EventBusInstance._internal() {
    _eventBus = EventBus();
  }

  late EventBus _eventBus;

  Stream<T> on<T>() {
    return _eventBus.on<T>();
  }

  void fire(event) {
    _eventBus.fire(event);
  }
}

mixin EventBusMixin on ChangeNotifier {
  final List<StreamSubscription> _subscriptions = [];

  @protected
  Stream<T> on<T>() {
    return _EventBusInstance._instance.on<T>();
  }

  @protected
  void observeEvent<T>(void Function(T event)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    StreamSubscription<T> sub = on<T>().listen(onData,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError);
    _subscriptions.add(sub);
  }

  @protected
  void fire(event) {
    return _EventBusInstance._instance.fire(event);
  }

  @override
  void dispose() {
    super.dispose();
    for (StreamSubscription sub in _subscriptions) {
      sub.cancel();
    }
  }
}
