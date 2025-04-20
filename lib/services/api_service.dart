import 'package:lock_unlock_gate/domain/entities/lock_entity.dart';
import 'package:lock_unlock_gate/drivers/api/api_driver.dart';
import 'package:lock_unlock_gate/services/injector.dart';
import 'package:lock_unlock_gate/services/service.dart';

class ApiService extends Service {

  final ApiDriver _driver = Injector.instance.locate();

  Future<bool> unlockLock(LockEntity lock) => _driver.unlockLock(lock);
}