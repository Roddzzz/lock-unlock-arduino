import 'package:lock_unlock_gate/domain/entities/lock_entity.dart';
import 'package:lock_unlock_gate/services/component.dart';
import 'package:lock_unlock_gate/services/database_service.dart';
import 'package:lock_unlock_gate/services/injector.dart';

class LocksModel extends Component {

  final DatabaseService _databaseService = Injector.instance.locate();

  List<LockEntity>? _locks;

  Future<List<LockEntity>?> _queryAllLocks(String userId) async {
    return await _databaseService.queryAllLocks(userId);
  }

  // view model só vai chamar este método. Se não tiver armazenado, busca da base.
  // se estiver carregado mas o parâmetro force for passado ele tenta de novo na base, forçando a consulta
  Future<List<LockEntity>?> getLocks(String userId, bool force) async {
    if(_locks == null || force) {
      await _queryAllLocks(userId);
    }
    return _locks;
  }
}