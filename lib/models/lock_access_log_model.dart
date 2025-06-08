import 'package:lock_unlock_gate/domain/entities/access_log_entity.dart';
import 'package:lock_unlock_gate/services/component.dart';
import 'package:lock_unlock_gate/services/database_service.dart';
import 'package:lock_unlock_gate/services/injector.dart';

class LockAccessLogModel extends Component {

  final DatabaseService _databaseService = Injector.instance.locate();

  List<AccessLogEntity> _accessLogs = [];

  List<AccessLogEntity> get access_logs => _accessLogs;

  Future<bool> queryLogs() async {
    final result = await _databaseService.queryUnlockAccessLogs();
    if (result == null) {
      return false;
    }
    _accessLogs = result;
    return true;
  }
}