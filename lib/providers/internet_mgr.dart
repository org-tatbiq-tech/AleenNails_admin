import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

enum InternetConnectionStatus {
  connected,
  offline,
  waiting,
}

class InternetMgr extends ChangeNotifier {
  InternetConnectionStatus status = InternetConnectionStatus.waiting;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _streamSubscription;

  void checkConnectivity() async {
    var connectionResult = await _connectivity.checkConnectivity();
    if (connectionResult == ConnectivityResult.mobile ||
        connectionResult == ConnectivityResult.wifi) {
      status = InternetConnectionStatus.connected;
      notifyListeners();
    } else {
      status = InternetConnectionStatus.offline;
      notifyListeners();
    }
  }

  void checkRealtimeConnection() {
    _streamSubscription = _connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi) {
        status = InternetConnectionStatus.connected;
      } else {
        status = InternetConnectionStatus.offline;
      }
      notifyListeners();
    });
  }
}
