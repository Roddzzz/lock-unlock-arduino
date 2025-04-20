import 'package:lock_unlock_gate/domain/entities/lock_entity.dart';
import 'package:lock_unlock_gate/domain/request/unlock_request.dart';
import 'package:lock_unlock_gate/drivers/api/api_driver.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:lock_unlock_gate/drivers/api/mappers/api_request_response_mapper.dart';
import 'package:lock_unlock_gate/services/injector.dart';

class CloudFunctionsApiDriver extends ApiDriver {

  final _api = FirebaseFunctions.instance;
  final ApiRequestResponseMapper _mapper = Injector.instance.locate();


  @override
  Future<bool> unlockLock(LockEntity lock) async {
    try {
      final result = await _api.httpsCallable('lock').call(
        _mapper.fromUnlockRequestEntityToJson(UnlockRequest(lockId: lock.id))
      );
      final response = _mapper.fromJsonToUnlockResponse(result.data);
      return response.success;
    } catch(error, stack_trace) {
      print(error);
      print(stack_trace);
      return false;
    }
  }

}