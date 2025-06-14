import 'package:lock_unlock_gate/domain/entities/access_log_entity.dart';
import 'package:lock_unlock_gate/domain/entities/lock_entity.dart';
import 'package:lock_unlock_gate/services/component.dart';

abstract class DatabaseDriver extends Component {

  /// Este método é responsável por buscar todas as fechaduras do usuário
  /// 
  /// O [userId] é ID do usuário de quem serão consultadas as fechaduras
  /// 
  /// Retorna a lista de fechaduras que aquele usuário tem acesso
  Future<List<LockEntity>?> queryAllLocks(String userId);



  /// Este método é responsável por buscar todos os logs de acesso de fechaduras
  /// 
  /// Retorna uma lista de logs de acesso
  Future<List<AccessLogEntity>?> queryUnlockAccessLogs();
}