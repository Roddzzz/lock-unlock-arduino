import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lock_unlock_gate/domain/entities/access_log_entity.dart';
import 'package:lock_unlock_gate/domain/entities/lock_entity.dart';
import 'package:lock_unlock_gate/domain/entities/user_entity.dart';
import 'package:lock_unlock_gate/drivers/driver.dart';

class FirebaseDatabaseObjectMapperDriver extends Driver {

  LockEntity fromJsonToLockEntity(Map<String, dynamic> data) {
    return LockEntity(id: data['id'], name: data['name'], locked: data['locked']);
  }

  AccessLogEntity fromJsonToAccessLogEntity(Map<String, dynamic> data) {
    Timestamp timestamp = data['timestamp'];

    return AccessLogEntity(id: data['id'], lock: fromJsonToLockEntity(data['lock']), timestamp: timestamp.toDate(), user: fromJsonToUserEntity(data['user']));
  }

  UserEntity fromJsonToUserEntity(Map<String, dynamic> data) {
    return UserEntity(id: data['id'], name: data['name']);
  }
  


}