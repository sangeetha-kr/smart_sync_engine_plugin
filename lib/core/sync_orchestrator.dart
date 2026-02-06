import '../domain/sync_task.dart';
import '../storage/sync_storage.dart';
import 'network_monitor.dart';
import 'retry_policy.dart';
import 'progress_bus.dart';

class SyncOrchestrator {
  final SyncStorage storage;
  final ProgressBus _progress = ProgressBus();

  bool _running = false;
  bool _online = true;

  Stream<double> get progress => _progress.stream;

  SyncOrchestrator(this.storage) {
    NetworkMonitor.start();

    NetworkMonitor.onChange.listen((status) {
      _online = status;

      if (_online) {
        _kick(); // resume when back online
      }
    });
  }

  Future<void> enqueue(SyncTask task) async {
    await storage.save(task);
    _kick();
    return task.completer.future;
  }

  void _kick() {
    if (!_running && _online) {
      _running = true;
      _process();
    }
  }

  Future<void> _process() async {
    try {
      while (_online) {
        final tasks = await storage.all();
        if (tasks.isEmpty) break;

        int completed = 0;
        final total = tasks.length;

        for (final task in tasks) {
          if (!_online) break;

          try {
            task.status = SyncStatus.running;

            await task.action();

            task.status = SyncStatus.success;
            await storage.delete(task.id);

            if (!task.completer.isCompleted) {
              task.completer.complete();
            }
          } catch (e) {
            task.retryCount++;

            if (!RetryPolicy.shouldRetry(task.retryCount)) {
              task.status = SyncStatus.failed;
              await storage.delete(task.id);

              if (!task.completer.isCompleted) {
                task.completer.completeError(e);
              }
            } else {
              await Future.delayed(
                RetryPolicy.nextDelay(task.retryCount),
              );
            }
          }

          completed++;
          _progress.emit(completed, total);
        }
      }
    } finally {
      _running = false;

      // in case new tasks were added while finishing
      if (_online) {
        final remaining = await storage.all();
        if (remaining.isNotEmpty) {
          _kick();
        }
      }
    }
  }
}
