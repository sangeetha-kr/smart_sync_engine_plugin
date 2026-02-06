import '../domain/sync_task.dart';
import 'sync_storage.dart';

class MemoryStorage implements SyncStorage {
  final Map<String, SyncTask> _queue = {};

  @override
  Future<void> save(SyncTask task) async {
    _queue[task.id] = task;
  }

  @override
  Future<void> delete(String id) async {
    _queue.remove(id);
  }

  @override
  Future<List<SyncTask>> all() async => _queue.values.toList();

  @override
  Future<void> clear() async => _queue.clear();
}
