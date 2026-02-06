import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkMonitor {
  static final _controller = StreamController<bool>.broadcast();

  static Stream<bool> get onChange => _controller.stream;

  static void start() {
    Connectivity().onConnectivityChanged.listen(
      (r) => _controller.add(r != ConnectivityResult.none),
    );
  }
}
