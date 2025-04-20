import 'package:flutter/material.dart';
import 'package:lock_unlock_gate/domain/entities/lock_entity.dart';
import 'package:lock_unlock_gate/domain/enums/loading_status.dart';
import 'package:lock_unlock_gate/models/locks_model.dart';
import 'package:lock_unlock_gate/services/auth_service.dart';
import 'package:lock_unlock_gate/services/injector.dart';

class HubScreenViewmodel extends ChangeNotifier {

  final LocksModel _locksModel = Injector.instance.locate();
  final AuthService _authService = Injector.instance.locate();

  LoadingStatus locksLoadingStatus = LoadingStatus.NOT_DIRTY;

  Future<void> queryLocks() async {
    locksLoadingStatus = LoadingStatus.LOADING;
    notifyListeners();
    final success = await _locksModel.queryAllLocks(_authService.getUserId());
    if(!success) {
      locksLoadingStatus = LoadingStatus.ERROR;
    } else {
      locksLoadingStatus = LoadingStatus.SUCCESS;
    }
    notifyListeners();
  }

  List<LockEntity> get locks => _locksModel.locks;
}