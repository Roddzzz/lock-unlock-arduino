import 'package:flutter/material.dart';
import 'package:lock_unlock_gate/domain/entities/access_log_entity.dart';
import 'package:lock_unlock_gate/domain/enums/loading_status.dart';
import 'package:lock_unlock_gate/models/lock_access_log_model.dart';
import 'package:lock_unlock_gate/services/injector.dart';

class AccessLogScreenViewmodel extends ChangeNotifier {

  AccessLogScreenViewmodel() {
    _setUp();
  }
  
  final LockAccessLogModel _model = Injector.instance.locate();

  LoadingStatus _loadingStatus = LoadingStatus.NOT_DIRTY;

  LoadingStatus get loadingStatus => _loadingStatus;
  List<AccessLogEntity> get accessLogs => _model.access_logs;


  Future<void> _setUp() async {
    queryLogs();
  }

  Future<void> queryLogs() async {
    _loadingStatus = LoadingStatus.LOADING;
    notifyListeners();
    bool success = await _model.queryLogs();
    if (success) {
      _model.sortLogsByTimestamp();
      _loadingStatus = LoadingStatus.SUCCESS;
    } else {
      _loadingStatus = LoadingStatus.ERROR;
    }
    notifyListeners();
  }

}