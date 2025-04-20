class LockEntity {

  final String id;
  final String name;
  bool locked;

  LockEntity({required this.id, required this.name, this.locked = true});
}