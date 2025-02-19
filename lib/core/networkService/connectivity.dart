import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> connectedToNetwork({bool showSnackBar = true}) async {
  final List<ConnectivityResult> result =
      await (Connectivity().checkConnectivity());
  if (result.contains(ConnectivityResult.mobile)) {
    return true;
  } else if (result.contains(ConnectivityResult.wifi)) {
    return true;
  } else {
    return false;
  }
}
