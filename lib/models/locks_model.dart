import 'package:lock_unlock_gate/domain/entities/lock_entity.dart';
import 'package:lock_unlock_gate/services/component.dart';
import 'package:lock_unlock_gate/services/database_service.dart';
import 'package:lock_unlock_gate/services/injector.dart';

class LocksModel extends Component {

  final DatabaseService _databaseService = Injector.instance.locate();

  List<LockEntity> _locks = [];

  List<LockEntity> get locks => _locks;

  Future<bool> queryAllLocks(String userId) async {
    final result = await _databaseService.queryAllLocks(userId);
    if(result == null) {
      return false;
    }
    _locks = result;
    return true;
  }



}