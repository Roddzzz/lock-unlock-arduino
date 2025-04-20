import 'package:lock_unlock_gate/domain/request/unlock_request.dart';
import 'package:lock_unlock_gate/domain/response/unlock_response.dart';
import 'package:lock_unlock_gate/services/component.dart';

class ApiRequestResponseMapper extends Component {

  Map<String, dynamic> fromUnlockRequestEntityToJson(UnlockRequest unlockRequest) {
    final Map<String, dynamic> map = {};
    map['lockId'] = unlockRequest.lockId;
    return map;
  }

  UnlockResponse fromJsonToUnlockResponse(Map<String, dynamic> response) {
    return UnlockResponse(lockId: response['lockId'], success: response['success'], errorMessage: response['errorMessage']);
  }
}