import 'package:flutter/material.dart';
import 'package:smart_sync_engine/smart_sync_engine.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,

      home: Scaffold(
        appBar: AppBar(title: const Text("Smart Sync Engine")),
        body: Center(
          child:ElevatedButton(
  onPressed: () async {
    await SmartSyncEngine.execute(
      key: 'upload',
      request: () async {
        await Future.delayed(const Duration(seconds: 2));
      },
    );
  },
  child: const Text('Sync'),
)

        ),
      ),
    );
  }
}
