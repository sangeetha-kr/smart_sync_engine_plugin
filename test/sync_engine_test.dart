import 'package:flutter_test/flutter_test.dart';
import 'package:smart_sync_engine/smart_sync_engine.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized(); // 🔥 REQUIRED

  test('Executes task successfully', () async {
    bool executed = false;

    await SmartSyncEngine.execute(
      key: 'task1',
      request: () async {
        executed = true;
      },
    );

    expect(executed, true);
  });

  test('Retries on failure then succeeds', () async {
    int calls = 0;

    await SmartSyncEngine.execute(
      key: 'retry',
      request: () async {
        calls++;
        if (calls < 2) throw Exception();
      },
    );

    expect(calls, 2);
  });
}
