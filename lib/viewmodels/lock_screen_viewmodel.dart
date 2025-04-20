import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lock_unlock_gate/domain/enums/loading_status.dart';
import 'package:lock_unlock_gate/models/locks_model.dart';
import 'package:lock_unlock_gate/services/injector.dart';

class LockScreenViewmodel extends ChangeNotifier {

  final LocksModel _model = Injector.instance.locate();

  bool get locked => _model.isLocked();

  LoadingStatus loadingStatus = LoadingStatus.NOT_DIRTY;

  late StreamSubscription<bool> _currentLockStreamSubscription;

  LockScreenViewmodel() {
    _setUp();
  }

  Future<void> _setUp() async {
    _currentLockStreamSubscription = _model.onCurrentLockUpdate.listen((data) => _onCurrentLockStatusUpdate());
  }

  Future<bool> unlock() async {
    loadingStatus = LoadingStatus.LOADING;
    notifyListeners();
    final success = await _model.unlock();
    if(success) {
      loadingStatus = LoadingStatus.SUCCESS;
    } else {
      loadingStatus = LoadingStatus.ERROR;
    }
    notifyListeners();
    return success;
  }

  void _onCurrentLockStatusUpdate() {
    loadingStatus = LoadingStatus.NOT_DIRTY;
    notifyListeners();
  }

  Future<void> tearDown() async {
    await _currentLockStreamSubscription.cancel();
  }
}