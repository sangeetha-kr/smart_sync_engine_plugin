typedef ConflictHook = Future<void> Function(
  String key,
  Object local,
  Object remote,
);