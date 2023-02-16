import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityMock {
  final StreamController<ConnectivityResult> connectivityStreamController =
  StreamController<ConnectivityResult>.broadcast();

  Stream<ConnectivityResult> get onConnectivityChanged =>
      connectivityStreamController.stream;
}