import 'dart:async';

enum SyncStatus { pending, running, success, failed }

class SyncTask {
  final String id;
  final String key;
  final Future<void> Function() action;
  final Completer<void> completer = Completer<void>();

  int retryCount;
  SyncStatus status;

  SyncTask({
    required this.id,
    required this.key,
    required this.action,
    this.retryCount = 0,
    this.status = SyncStatus.pending,
  });
}
