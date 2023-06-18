import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

class _State {
  final String name;

  int _value = 0;

  int get value => _value;

  _State({required this.name});

  void increasedTag() {
    if (_value > 10) {
      _value = 0;
    }
    _value++;
  }
}

mixin NotifyMixin on ChangeNotifier {
  bool _disposed = false;

  bool get shouldLog => true;
  final Map<String, _State> _updatedIds = {};

  bool _hasRegister = false;

  bool get hasRegister => _hasRegister;

  @protected
  @mustCallSuper
  @override
  void dispose() {
    super.dispose();
    logMessage("-- 销毁了");
    _updatedIds.clear();
    _disposed = true;
  }

  @protected
  @mustCallSuper
  void registerIds(List<String> ids) {
    logMessage("--注册了--ids: $ids");
    for (String name in ids) {
      _updatedIds[name] = _State(name: name);
    }
    _hasRegister = true;
  }

  @protected
  @mustCallSuper
  void clearRegisteredIds() {
    _updatedIds.clear();
  }

  @protected
  @mustCallSuper
  void clearSingleId(String id) {
    _updatedIds.remove(id);
  }

  @protected
  @mustCallSuper
  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @protected
  @mustCallSuper
  void notifyMultiListeners(List<String> ids) {
    assert(hasRegister, 'registerIds方法还没有调用');
    logMessage("--更新了--ids: $ids");
    if (ids.isEmpty) return;
    for (String id in ids) {
      assert(containsId(id), 'Id: $id 需要在registerIds中注册后才能使用');
      _updatedIds[id]?.increasedTag();
    }

    ///如果正处于build阶段，则等待build结束后再更新
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    } else {
      notifyListeners();
    }
  }

  @protected
  @mustCallSuper
  void notifySingleListener(String id) {
    assert(hasRegister, 'registerIds方法还没有调用');
    logMessage("--更新了--id: $id ");
    assert(containsId(id), 'id: $id 需要在registerIds中注册后才能使用');
    _updatedIds[id]?.increasedTag();

    ///如果正处于build阶段，则等待build结束后再更新
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    } else {
      notifyListeners();
    }
  }

  bool containsId(String id) {
    return _updatedIds.containsKey(id);
  }

  bool containsMultiId(List<String> ids) {
    for (String id in ids) {
      if (!containsId(id)) {
        assert(containsId(id), 'id: $id 需要在registerIds中注册后才能使用');
        return false;
      }
    }
    return true;
  }

  int getIdValue(String id) {
    return _updatedIds[id]?.value ?? 0;
  }

  int getMultiIdValue(List<String> ids) {
    int value = 0;
    for (String id in ids) {
      value += getIdValue(id);
    }
    return value;
  }

  void logMessage(String message) {
    if (kDebugMode && shouldLog) {
      log(message, name: runtimeType.toString());
    }
  }
}
