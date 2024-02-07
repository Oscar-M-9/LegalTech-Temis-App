// network_util.dart
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkUtil {
  static Future<bool> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
