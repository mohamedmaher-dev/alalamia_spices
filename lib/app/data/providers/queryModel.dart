import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:alalamia_spices/app/exports/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// General model used to help retrieve, parse & storage
// information from a public REST API
enum Status { loading, error, loaded, onLine }

String next = '';

abstract class QueryModel with ChangeNotifier {
  final Dio _dio = Dio(
    BaseOptions(
        responseType: ResponseType.json,
        connectTimeout: 80000,
        receiveTimeout: 80000,
        headers: {
          'Authorization': 'Bearer ' + appModel.token,
          'lang': allTranslations.currentLanguage,
          'Content-type': 'application/json',
        },
        validateStatus: (code) {
          if ((code! >= 200 && code <= 300) || code == 401) {
            return true;
          }
          return false;
        }),
  );

  // Lists of both models info & its photos
  final List items;
  final List links;

  Map errors = {};

  // Model's status regarding data loading capabilities
  Status? _status;

  QueryModel(BuildContext context)
      : items = [],
        links = [] {
    startLoading();
    loadData(context);
  }

  // Future<Database> get _db async => await AppDatabase.instance.database;

  // Future saveLocalData(String url, var data) async {
  //   var store = intMapStoreFactory.store(url);
  //   // var store = intMapStoreFactory.store(url);
  //   try {
  //     await store.delete(await _db);
  //   } catch (e) {}
  //
  //   try {
  //     await store.add(await _db, data);
  //   } catch (e) {
  //     await store.add(await _db, data);
  //   }
  // }

  /// this function to fetch data locally using specific token
//   Future fetchDataFromLocal(String url, {Map<String, dynamic>? parameters}) async {
//
//     final Dio _dio = Dio(
//       BaseOptions(
//           responseType: ResponseType.json,
//           connectTimeout: 80000,
//           receiveTimeout: 80000,
//           headers: {
//             'Authorization': 'Bearer '
//             + "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiZDhiYzBiZTY0ZTcwNWJhMWYwZmExNmE4NTk5MTJiZTU1YTM0ZTBmZjVkZjFhN2JhMzhhNTRkNDBhNTIzOGM3NmM0YTU2MGE1NzFjNGEzMDgiLCJpYXQiOjE2NzQzNjkwMDMuOTcxNDcsIm5iZiI6MTY3NDM2OTAwMy45NzE0NzUsImV4cCI6MTY5MDAwNzQwMy44OTc4ODksInN1YiI6IjYiLCJzY29wZXMiOltdfQ.kTuUKWZU2ckhi5MKjXRfEf6C69e4fWa2Om2LWp30vzh6S-NgRthY0b0gyEx0bUDihOXiVL2MHpx3CEGiyT8kfXiPzhlmCSx6TAKLFPRKm4Q6-C3SSPWJoE2iu88vbuGDBp4fQr7Lm2lpBB6xH945R9JMAzlVQC3L1wtHMxbWohpUwT35l6-cVLXfrxEXnURXx58-zEumVtHzUMY-QiZqwl0vZ6P1rtBOKXArGqnvJzXB4z9bqFy1nxJeto3pupEEBdGKh-MHa2HtGQxTicGbuoojnXlWIHoTLWOHuqyU85oQ44L9g_oKJORzMU9qckKvLwZNqj2vt_BVH1eK5mycoyF0SLts79jpi-gXpJxqG0hSXXyqZ4dsme1WxirT8VwuPCoCg4DvjE1mMNXA_vUWVp9iOxj8C6sFOJhCVBmLWsNr8QjTlUKDRU0pmp3uEGPl9M9IFz1gUtWK_yUfWLvor271sozZGn_2rk-USvMjRIXEFoSpZMUSYttXzLF5jM2JYUIXuuSwvWXazhkFOIZ9txKaxI8KCrZ6yvsBUtfZEpHy67_mcabFDAFc5Wl0r075SePixfA5URx9lqhuG1LSnQeDkmS5Q6WdQZuDWJuMR3RfaOTjBfMsgH1XBy4Yk8qCjXL1BvzM1A54c6pW4GZxfxYKsliOcM1Kp3cQ0QAUX9I",
//                 // + "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMjQwM2JlMTUzNjkxZThlZDhmNjM5OGEzMDAwYzAzODVhODY0NWMwZGI4MTU3ZjUxODk4NmVkNTYyZmQ5MTg5YjczNGUzMDI1MWIxNDQzMTgiLCJpYXQiOjE2NzI1Njc3OTEsIm5iZiI6MTY3MjU2Nzc5MSwiZXhwIjoxNzA0MTAzNzkxLCJzdWIiOiIxMyIsInNjb3BlcyI6W119.C8nJG5z1s2hSQLOd10CeZNTlXmzjOxUrWX_XhHYHEuxtiPmAP4bng4dueaPLMQj7u1bY0P2EY_a9WeporPWyZ3wiCiiDiqTssa8d_G77yxmigkIOXydbhRqFIZs9MckvWkpbcftK7kg0xcX3DQY_7Vpi5ben4668arLTylV8lo6E2PAw2QSHWJSef2fS9jn6pyH5OXPoPwHQg6N8p8tKiH4-yksr6_ZeXm83gkoLO6N4gmy92n8cCxExqEsd8_H7EDBg7G8rPOrdiDrs-G_C-DmGVtMY1TQov1MGRHmfaqOECfjQn6TYvEUbOLjmL5xaVnyDlF3ZBiffpUNO7WxSFFJp7QTetwpU20lbvW2YG6a-Mm-LC7_KdvY6kDLM82AYldEihdxBvJQMHW2qtiCdn7_DM3q82UEQf2RsSOSsWxm5J1xtiTDO5lqeqCKsrau8rs4KHrJTLkMosR5Lh1Qi6GACXq4SHBPw86K_SH5ya1ulq3UjrNI6_RpUgNTyzIImofaxQSw9HRAAUl4q4_eKrf_wUAVK8v_Q0ybYzwbSzETmKElieX8_KYnv2iXc9I82M7t4_wiwFyA6Lt4jAH2oc3GiD5CyyoJRuauNi3xOPvmj5MrOEdu-j_w3D5zP4joqgz0GokwX2fi_1XqK81KPnU3OCHK86KdAWltEowwrUAA",
//             'lang': allTranslations.currentLanguage,
//             'Content-type': 'application/json',
//           },
//           validateStatus: (code) {
//             if ((code! >= 200 && code <= 300) || code == 401) {
//               return true;
//             }
//             return false;
//           }),
//     );
//
//     DioCacheManager _dioCacheManager;
//     _dioCacheManager = DioCacheManager(CacheConfig());
//
//     Options _cacheOptions = buildCacheOptions(Duration(days: 2) ,maxStale: Duration(days: 7) , forceRefresh: true);
//     _dio.interceptors.add(_dioCacheManager.interceptor);
//
//
//     try {
//       final response = await _dio.get(url,
//           queryParameters: parameters,
//           options: _cacheOptions);
// //          Options(headers: {
// //            'Authorization': 'Bearer ' + appModel.token,
// //          }));
//       if (!url.contains('page')) items.clear();
//       if (errors.isNotEmpty) errors.clear();
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         saveLocalData(url, response.data);
//         finishLoading();
//         return response.data;
//       } else if (response.statusCode == 401) {
//         if (response.data['error']["massage"] == "Unauthorized")
//           appModel.setApplicationSavedInformation('token', '');
//         receivedError();
//         errors = response.data['error'];
//         return errors;
//       } else {
//         receivedError();
//         throw Exception('Authentication Error');
//       }
//     } on DioError catch (exception) {
//       if (exception == null ||
//           exception.toString().contains('SocketException')) {
//         throw Exception("Network Error");
//       } else if (exception.type == DioErrorType.receiveTimeout ||
//           exception.type == DioErrorType.connectTimeout) {
//         throw Exception(
//             "Could'nt connect, please ensure you have a stable network.");
//       } else {
//         return [];
//       }
//     }
//   }

  ///this function to fetch data from api  and store it in cache
  Future fetchDataa(String url, String sortOrder,
      {Map<String, dynamic>? parameters, bool fromCash = false}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (await canLoadData() && !fromCash) {
      return fetchDataFromServer(url, parameters: {});
    } else {
      startLoading();

      // return fetchDataFromCache(url, sortOrder);
      String? responseData = prefs.getString(url);
      if (responseData != null) {
        return jsonDecode(responseData);
      } else {
        // if there is no response data in shared preferences, return an empty list
        return [];
      }
    }
  }

  Future fetchDataFromServer(String url,
      {Map<String, dynamic>? parameters}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DioCacheManager dioCacheManager;
    dioCacheManager = DioCacheManager(CacheConfig());

    Options cacheOptions = buildCacheOptions(const Duration(days: 2),
        options: Options(headers: {
          'Authorization': 'Bearer ' + appModel.token,
        }),
        maxStale: const Duration(days: 7),
        forceRefresh: true);
    _dio.interceptors.add(dioCacheManager.interceptor);

    try {
      final response = await _dio.get(url,
          queryParameters: parameters, options: cacheOptions);
//          Options(headers: {
//            'Authorization': 'Bearer ' + appModel.token,
//          }));
      if (!url.contains('page')) items.clear();
      if (errors.isNotEmpty) errors.clear();
      if (response.statusCode == 200 || response.statusCode == 201) {
        // saveLocalData(url, response.data) ;
        // save the response data as a string in shared preferences
        await prefs.setString(url, jsonEncode(response.data));
        finishLoading();
        return response.data;
      } else if (response.statusCode == 401) {
        if (response.data['error']["massage"] == "Unauthorized")
          appModel.setApplicationSavedInformation('token', '');
        receivedError();
        errors = response.data['error'];
        return errors;
      } else {
        receivedError();
        throw Exception('Authentication Error');
      }
    } on DioError catch (exception) {
      if (exception.toString().contains('SocketException')) {
        throw Exception("Network Error");
      } else if (exception.type == DioErrorType.receiveTimeout ||
          exception.type == DioErrorType.connectTimeout) {
        throw Exception(
            "Could'nt connect, please ensure you have a stable network.");
      } else {
        return [];
      }
    }
  }

  // Future fetchDataFromCache(String url, String sortOrder) async {
  //   var store = intMapStoreFactory.store(url);
  //   var data = await store.find(await _db, finder: Finder(sortOrders: [SortOrder(sortOrder, false)]));
  //   if (!url.contains('page')) items.clear();
  //   if (data.isEmpty) {
  //     receivedError();
  //     return null;
  //   } else {
  //     return data[0];
  //   }
  // }

  // Fetches data & returns it

  Future fetchData(String url, {Map<String, dynamic>? parameters}) async {
    try {
      final response = await _dio.get(url,
          queryParameters: parameters,
          options: Options(headers: {
            'Authorization': 'Bearer ' + appModel.token,
          }));
      if (items.isNotEmpty) items.clear();

      if (errors.isNotEmpty) errors.clear();
      if (response.statusCode == 200 || response.statusCode == 201) {
        finishLoading();
        return response.data['data'];
      } else if (response.statusCode == 401) {
        if (response.data['error']["massage"] == "Unauthorized")
          appModel.setApplicationSavedInformation('token', '');
        receivedError();
        errors = response.data['error'];
        return errors;
      } else {
        receivedError();
        throw Exception('Authentication Error');
      }
    } on DioError catch (exception) {
      if (exception.toString().contains('SocketException')) {
        throw Exception("Network Error");
      } else if (exception.type == DioErrorType.receiveTimeout ||
          exception.type == DioErrorType.connectTimeout) {
      } else {
        return [];
      }
    }
  }

  ///not use
  Future fetchDataWithPagination(String url,
      {Map<String, dynamic>? parameters}) async {
    try {
      final response = await _dio.get(url,
          queryParameters: parameters,
          options: Options(headers: {
            'Authorization': 'Bearer ' + appModel.token,
          }));
      if (!url.contains('page')) items.clear();
      if (errors.isNotEmpty) errors.clear();
      if (response.statusCode == 200 || response.statusCode == 201) {
        finishLoading();
        return response.data;
      } else if (response.statusCode == 401) {
        if (response.data['error']["massage"] == "Unauthorized")
          appModel.setApplicationSavedInformation('token', '');
        receivedError();
        errors = response.data['error'];
        return errors;
      } else {
        receivedError();
        throw Exception('Authentication Error');
      }
    } on DioError catch (exception) {
      if (exception.toString().contains('SocketException')) {
        throw Exception("Network Error");
      } else if (exception.type == DioErrorType.receiveTimeout ||
          exception.type == DioErrorType.connectTimeout) {
        throw Exception(
            "Could'nt connect, please ensure you have a stable network.");
      } else {
        return [];
      }
    }
  }

  ///this function for send data to api

  Future saveData(String url,
      {required Map<String, dynamic> parameters}) async {
    try {
      errors.clear();
      final response = await _dio.post(url,
          data: FormData.fromMap(parameters),
          options: Options(headers: {
            'Authorization': 'Bearer ' + appModel.token,
          }));
      //if (items.isNotEmpty) items.clear();
      print("==================  ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        finishLoading();
        return response.data['data'];
      } else if (response.statusCode == 401) {
        receivedError();
        errors = response.data['error'];
        return response.data['error'];
      } else {
        receivedError();
        throw Exception('Authentication Error');
      }
    } on DioError catch (exception) {
      receivedError();
      if (exception.toString().contains('SocketException')) {
        throw Exception("Network Error");
      } else if (exception.type == DioErrorType.receiveTimeout ||
          exception.type == DioErrorType.connectTimeout) {
        throw Exception(
            "Could'nt connect, please ensure you have a stable network.");
      } else {
        return null;
      }
    }
  }

  Future saveDataWithoutFormData(String url,
      {required Map<String, dynamic> parameters}) async {
    try {
      errors.clear();
      final response = await _dio.post(url,
          data: parameters,
          options: Options(headers: {
            'Authorization': 'Bearer ' + appModel.token,
          }));
      if (items.isNotEmpty) items.clear();

      if (response.statusCode == 200 || response.statusCode == 201) {
        finishLoading();
        return response.data['data'];
      } else if (response.statusCode == 401) {
        if (response.data['error']["massage"] == "Unauthorized")
          appModel.setApplicationSavedInformation('token', '');
        receivedError();
        errors = response.data['error'];

        return errors;
      } else {
        receivedError();
        throw Exception('Authentication Error');
      }
    } on DioError catch (exception) {
      receivedError();
      if (exception.toString().contains('SocketException')) {
        throw Exception("Network Error");
      } else if (exception.type == DioErrorType.receiveTimeout ||
          exception.type == DioErrorType.connectTimeout) {
        throw Exception(
            "Could'nt connect, please ensure you have a stable network.");
      } else {
        return null;
      }
    }
  }

  Future editData(String url,
      {required Map<String, dynamic> parameters}) async {
    try {
      errors.clear();
      final response = await _dio.put(url,
          data: parameters,
          options: Options(headers: {
            'Authorization': 'Bearer ' + appModel.token,
          }));

      if (response.statusCode == 200 || response.statusCode == 201) {
        finishLoading();
        return response.data['data'];
      } else if (response.statusCode == 401) {
        if (response.data['error']["massage"] == "Unauthorized")
          appModel.setApplicationSavedInformation('token', '');
        receivedError();
        return response.data['error'];
      } else {
        receivedError();
        throw Exception('Authentication Error');
      }
    } on DioError catch (exception) {
      if (exception.toString().contains('SocketException')) {
        receivedError();
        throw Exception("Network Error");
      } else if (exception.type == DioErrorType.receiveTimeout ||
          exception.type == DioErrorType.connectTimeout) {
        receivedError();
        throw Exception(
            "Could'nt connect, please ensure you have a stable network.");
      } else {
        receivedError();
        return null;
      }
    }
  }

  Future deleteData(String url,
      {required Map<String, dynamic> parameters}) async {
    try {
      final response = await _dio.delete(url,
          data: FormData.fromMap(parameters),
          options: Options(headers: {
            'Authorization': 'Bearer ' + appModel.token,
          }));

      if (response.statusCode == 200 || response.statusCode == 201) {
        finishLoading();
        return response.data['data'];
      } else if (response.statusCode == 401) {
        if (response.data['error']["massage"] == "Unauthorized")
          appModel.setApplicationSavedInformation('token', '');
        return response.data['error'];
      } else
        throw Exception('Authentication Error');
    } on DioError catch (exception) {
      if (exception.toString().contains('SocketException')) {
        throw Exception("Network Error");
      } else if (exception.type == DioErrorType.receiveTimeout ||
          exception.type == DioErrorType.connectTimeout) {
        throw Exception(
            "Could'nt connect, please ensure you have a stable network.");
      } else {
        return null;
      }
    }
  }

  // Overridable method, used to load the model's data
  Future loadData([BuildContext context]);

  // Reloads model's data
  Future refreshData() async => await loadData();

  // General getters for both lists
  dynamic getItem(index) => items.isNotEmpty ? items[index] : null;

  int get getItemCount => items.length;

  // Status getters
  bool get isLoading => _status == Status.loading;
  bool get loadingFailed => _status == Status.error;
  bool get online => _status == Status.onLine;
  bool get isLoaded => _status == Status.loaded;

  // Methods which update the [_status] variable
  void isOnline() {
    _status = Status.onLine;
  }

  void startLoading() {
    _status = Status.loading;
  }

  void finishLoading() {
    _status = Status.loaded;
    notifyListeners();
  }

  void receivedError() {
    _status = Status.error;
    notifyListeners();
  }

  // Checks internet connection & sets [_status] variable
  Future<bool> canLoadData() async {
    ConnectivityResult connectivityResult =
        (await Connectivity().checkConnectivity());

    bool isConnected = connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;

    if (!isConnected) {
      receivedError();
    } else {
      startLoading();
    }

    return isLoading;
  }
}
