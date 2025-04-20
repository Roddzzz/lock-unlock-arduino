import 'package:lock_unlock_gate/domain/entities/lock_entity.dart';
import 'package:lock_unlock_gate/drivers/database/database_driver.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lock_unlock_gate/drivers/database/mappers/firebase_database_object_mapper_driver.dart';
import 'package:lock_unlock_gate/services/injector.dart';

class FirebaseDatabaseDriver extends DatabaseDriver {

  final _instance = FirebaseFirestore.instance;
  final FirebaseDatabaseObjectMapperDriver _mapper = Injector.instance.locate();


  @override
  Future<List<LockEntity>?> queryAllLocks(String userId) async {
    try {
      final queryResult = await _instance.collection('users').doc(userId).collection('locks').get();
      return queryResult.docs.where((e) => e.exists).map((e2) => _mapper.fromJsonToLockEntity(e2.data())).toList();
    } catch(_, _) {
      return null;
    }
  }

}