import 'package:connectivity/connectivity.dart';

Future<bool> connectedToNetwork({bool showSnackBar = true}) async {
  final Connectivity _connectivity = Connectivity();

  ConnectivityResult result = await _connectivity.checkConnectivity();
  if (result == ConnectivityResult.mobile ||
      result == ConnectivityResult.wifi) {
    return true;
  } else {
    return false;
  }
}
