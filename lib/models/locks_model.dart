import 'dart:async';

import 'package:lock_unlock_gate/domain/entities/lock_entity.dart';
import 'package:lock_unlock_gate/services/component.dart';
import 'package:lock_unlock_gate/services/database_service.dart';
import 'package:lock_unlock_gate/services/injector.dart';

class LocksModel extends Component {

  final DatabaseService _databaseService = Injector.instance.locate();

  List<LockEntity> _locks = [];

  List<LockEntity> get locks => _locks;

  LockEntity? currentLock;

  final StreamController<bool> _currentLockStreamController = StreamController();

  Stream<bool> get onCurrentLockUpdate => _currentLockStreamController.stream;

  Future<bool> queryAllLocks(String userId) async {
    final result = await _databaseService.queryAllLocks(userId);
    if(result == null) {
      return false;
    }
    _locks = result;
    return true;
  }

  void setCurrentLock(LockEntity lock) {
    currentLock = lock;
  }

  bool isLocked() => currentLock?.locked?? false;

  Future<bool> unlock() async {
    await Future.delayed(Duration(seconds: 2));
    currentLock?.locked = false;
    lockBack();
    return true;
  }

  Future<void> lockBack() async {
    await Future.delayed(Duration(seconds: 2));
    currentLock?.locked = true;
    _currentLockStreamController.sink.add(true);
  }



}