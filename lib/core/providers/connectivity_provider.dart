import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

class ConnectivityProvider extends ChangeNotifier {
  ConnectivityResult _connectivityResult = ConnectivityResult.none;

  ConnectivityProvider() {
    _initConnectivity();
    Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
  }

  ConnectivityResult get connectivityResult => _connectivityResult;

  Future<void> _initConnectivity() async {
    _connectivityResult = await Connectivity().checkConnectivity();
    notifyListeners();
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    _connectivityResult = result;
    notifyListeners();
  }
}
