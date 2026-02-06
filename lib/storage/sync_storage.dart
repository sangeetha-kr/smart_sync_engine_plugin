import '../domain/sync_task.dart';

abstract class SyncStorage {
  Future<void> save(SyncTask task);
  Future<void> delete(String id);
  Future<List<SyncTask>> all();
  Future<void> clear();
}
