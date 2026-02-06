<<<<<<< HEAD
# Smart Sync Engine

A production-grade offline-first sync and retry manager for Flutter apps.

## Features

- Offline queue  
- Automatic retries with limits
- Conflict resolution strategies  
- Network-aware syncing
- Works on Android, iOS, Web, Desktop  
- No native dependencies  

## Usage

```dart
final engine = SmartSyncEngine(maxRetries: 3);

engine.enqueue(
  SyncTask(
    id: 'save_order',
    operation: () async {
      await api.saveOrder();
    },
  ),
);

await engine.syncNow();


=======
# smart_sync_engine_plugin
Enterprise-grade offline sync and automatic retry engine for Flutter applications.
>>>>>>> c5f40637425429cbed160df8cb249497d268b811
