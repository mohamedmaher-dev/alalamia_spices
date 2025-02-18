//
// import 'package:alalamia_spices/app/data/model/translations.dart';
// import 'package:alalamia_spices/app/exports/services.dart';/snack_bar_service.dart';
// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'dart:developer' as developer;
//
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// // bool? isOnline;
// class NoConnectionSnackBar extends StatefulWidget {
//
//    const  NoConnectionSnackBar({
//      Key? key,
//
//    }) : super(key: key);
//
//   @override
//   State<NoConnectionSnackBar> createState() => _NoConnectionSnackBarState();
// }
//
// class _NoConnectionSnackBarState extends State<NoConnectionSnackBar> {
//
//   ConnectivityResult? _connectionStatus ;
//   final Connectivity _connectivity = Connectivity();
//   late StreamSubscription<ConnectivityResult> _connectivitySubscription;
//
//   @override
//   void initState() {
//     super.initState();
//     initConnectivity();
//     _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
//   }
//
//
//   @override
//   void dispose() {
//     _connectivitySubscription.cancel();
//     super.dispose();
//   }
//
//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initConnectivity() async {
//     late ConnectivityResult result;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       result = await _connectivity.checkConnectivity();
//     } on PlatformException catch (e) {
//       developer.log('Couldn\'t check connectivity status', error: e);
//       return;
//     }
//
//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) {
//       return Future.value(null);
//     }
//
//     return _updateConnectionStatus(result);
//   }
//
//   Future<void> _updateConnectionStatus(ConnectivityResult result) async {
//     setState(() {
//       _connectionStatus = result;
//        // isOnline =  result == ConnectivityResult.none
//        // ? false
//        // : true;
//     });
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       bottomNavigationBar: _connectionStatus == ConnectivityResult.none
//       ? Container(
//         height: 40.h,
//         color: Theme.of(context).primaryColor,
//         child: Center(
//           child: Text(
//               allTranslations.text("noInternet"),
//             style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//               fontWeight: FontWeight.bold
//             ),
//           ),
//         ),
//       )
//       : const SizedBox.shrink(),
//     );
//   }
// }
