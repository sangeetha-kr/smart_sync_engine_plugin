import 'package:flutter/material.dart';
import 'package:smart_sync_engine/smart_sync_engine.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SyncDemoScreen(),
    );
  }
}

class SyncDemoScreen extends StatefulWidget {
  const SyncDemoScreen({super.key});

  @override
  State<SyncDemoScreen> createState() => _SyncDemoScreenState();
}

class _SyncDemoScreenState extends State<SyncDemoScreen> {
  bool _isSyncing = false;
  String _status = 'Idle';

  Future<void> _startSync() async {
    setState(() {
      _isSyncing = true;
      _status = 'Syncing...';
    });

    try {
      await SmartSyncEngine.execute(
        key: 'upload_task',
        request: () async {
          await Future.delayed(const Duration(seconds: 2));
        },
      );

      setState(() => _status = 'Sync completed ✅');
    } catch (e) {
      setState(() => _status = 'Sync failed ❌');
    } finally {
      setState(() => _isSyncing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Sync Engine Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _status,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            _isSyncing
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _startSync,
                    child: const Text('Start Sync'),
                  ),
          ],
        ),
      ),
    );
  }
}
