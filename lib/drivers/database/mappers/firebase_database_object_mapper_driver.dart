import 'package:lock_unlock_gate/domain/entities/lock_entity.dart';
import 'package:lock_unlock_gate/drivers/driver.dart';

class FirebaseDatabaseObjectMapperDriver extends Driver {

  LockEntity fromJsonToLockEntity(Map<String, dynamic> data) {
    return LockEntity(id: data['id'], name: data['name'], locked: data['locked']);
  }
  


}