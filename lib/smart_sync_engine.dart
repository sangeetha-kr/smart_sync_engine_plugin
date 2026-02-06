library ;


import 'package:uuid/uuid.dart';

import 'core/sync_orchestrator.dart';
import 'domain/sync_task.dart';
import 'storage/memory_storage.dart';

class SmartSyncEngine {
  static final _storage = MemoryStorage();
  static final _orchestrator = SyncOrchestrator(_storage);

  static Stream<double> get progress => _orchestrator.progress;

  static Future<void> execute({
    required String key,
    required Future<void> Function() request,
  }) async {
    final task = SyncTask(
      id: const Uuid().v4(),
      key: key,
      action: request,
    );

    return _orchestrator.enqueue(task);
  }
}
