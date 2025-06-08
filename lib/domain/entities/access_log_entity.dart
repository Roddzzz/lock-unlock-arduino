import 'package:lock_unlock_gate/domain/entities/lock_entity.dart';
import 'package:lock_unlock_gate/domain/entities/user_entity.dart';

class AccessLogEntity {

  final String id;
  final LockEntity lock;
  final DateTime timestamp;
  final UserEntity user;

  AccessLogEntity({required this.id, required this.lock, required this.timestamp, required this.user});

}