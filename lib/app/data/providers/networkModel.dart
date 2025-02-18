//
// import 'dart:async';
//
// import 'package:connectivity_plus/connectivity_plus.dart';
//
// enum NetworkStatus {online , offline}
//
// class NetworkModel {
//
//   StreamController<NetworkStatus> controller = StreamController();
//
//   NetworkModel () {
//     Connectivity().onConnectivityChanged.listen((event) {
//
//       controller.add(_networkStatus(event));
//     });
//   }
//
//
//
//   NetworkStatus _networkStatus (ConnectivityResult connectivityResult){
//     return connectivityResult == ConnectivityResult.mobile ||
//         connectivityResult == ConnectivityResult.wifi
//         ? NetworkStatus.online
//         : NetworkStatus.offline;
//   }
//
// }