# Smart Sync Engine

**Smart Sync Engine** is a production-ready, offline-first synchronization and retry manager for Flutter applications.

It guarantees your critical tasks (API calls, uploads, background actions) are executed reliably — even when the network is unstable or unavailable.

Built for real-world production apps that demand reliability.

---

## Why Smart Sync Engine?

Mobile networks are unreliable.

This plugin ensures:

- No lost API requests  
- Automatic retries  
- Offline support  
- Smooth user experience  
- Zero manual retry logic  

---

## Features

- Persistent offline task queue  
- Automatic retries with limits  
- Network-aware syncing  
- Conflict handling (upcoming)  
- Android, iOS, Web, Desktop support  
- Lightweight and fast  
- No native configuration required  

---

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  smart_sync_engine: ^0.0.1
```

Then run:

```bash
flutter pub get
```

---

## Basic Usage

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
```

---

## How It Works

- Tasks are queued locally
- Internet connectivity is monitored
- When online → tasks execute automatically
- Failures retry based on policy
- Success removes task from queue

No lost actions. Ever.

---

## Common Use Cases

- E-commerce order submission
- Offline form saving
- File uploads
- Background sync
- Payment verification
- API reliability layer

---

## Configuration

```dart
final engine = SmartSyncEngine(
  maxRetries: 5,
  retryDelay: Duration(seconds: 5),
);
```
