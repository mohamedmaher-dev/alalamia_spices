
import 'package:flutter/material.dart';

import '../../services/connectivity_service.dart';

class ConnectivityNotifier extends ChangeNotifier {
  final ConnectivityService _connectivityService = ConnectivityService();
  bool _hasConnection = false;

  // A getter for the connection status
  bool get hasConnection => _hasConnection;

  // A constructor that initializes the connectivity service
  ConnectivityNotifier() {
    _connectivityService.initialize();
    _connectivityService.connectionChange.listen((bool isConnected) {
      _hasConnection = isConnected;
      notifyListeners();
    });
  }
}