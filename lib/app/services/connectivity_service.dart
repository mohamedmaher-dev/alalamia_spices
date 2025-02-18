import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  Connectivity connectivity = Connectivity();
  bool hasConnection = false;
  ConnectivityResult? connectionMedium;
  StreamController<bool> connectionChangeController =
  StreamController.broadcast();
  Stream<bool> get connectionChange => connectionChangeController.stream;

  void initialize() {
    _checkConnection();
    connectivity.onConnectivityChanged.listen(_connectionChange);
  }

  void disposeStream() => connectionChangeController.close();

  Future<void> _checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
        connectionMedium = await connectivity.checkConnectivity();
      }
    } on SocketException catch (_) {
      hasConnection = false;
    }
    connectionChangeController.add(hasConnection);
  }

  void _connectionChange(ConnectivityResult result) async {
    if (result == ConnectivityResult.none) {
      hasConnection = false;
    } else {
      await _checkConnection();
    }
    connectionMedium = result;
    connectionChangeController.add(hasConnection);
  }
}