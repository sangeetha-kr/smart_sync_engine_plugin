# Smart Sync Engine

A production-grade offline-first sync and retry manager for Flutter apps.

## Features

- Offline queue  
- Automatic retries  
- Conflict resolution strategies  
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


