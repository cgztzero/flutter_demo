
import 'package:connectivity_plus/connectivity_plus.dart';

///judge network status
class NetworkUtil {
  static Future<bool> isConnectedNetwork() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}
