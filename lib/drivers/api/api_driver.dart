import 'package:lock_unlock_gate/domain/entities/lock_entity.dart';
import 'package:lock_unlock_gate/drivers/driver.dart';

abstract class ApiDriver extends Driver {

  Future<bool> unlockLock(LockEntity lock);

}