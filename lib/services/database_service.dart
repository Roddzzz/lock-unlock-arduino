import 'package:lock_unlock_gate/domain/entities/access_log_entity.dart';
import 'package:lock_unlock_gate/domain/entities/lock_entity.dart';
import 'package:lock_unlock_gate/drivers/database/database_driver.dart';
import 'package:lock_unlock_gate/services/injector.dart';
import 'package:lock_unlock_gate/services/service.dart';

class DatabaseService extends Service {

  final DatabaseDriver _driver = Injector.instance.locate();

  Future<List<LockEntity>?> queryAllLocks(String userId) => _driver.queryAllLocks(userId);

  Future<List<AccessLogEntity>?> queryUnlockAccessLogs() => _driver.queryUnlockAccessLogs();

}