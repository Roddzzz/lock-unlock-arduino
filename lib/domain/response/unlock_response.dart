class UnlockResponse {

  final String lockId;
  final bool success;
  final String? errorMessage;

  UnlockResponse({required this.lockId, required this.success, this.errorMessage});
}