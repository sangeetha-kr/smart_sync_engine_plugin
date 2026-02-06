import 'dart:async';

class ProgressBus {
  final _controller = StreamController<double>.broadcast();

  Stream<double> get stream => _controller.stream;

  void emit(int done, int total) {
    if (total == 0) return;
    _controller.add(done / total);
  }

  void dispose() => _controller.close();
}
