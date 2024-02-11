import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectivityController {
  ValueNotifier<bool> isConnected = ValueNotifier(false);
  Future<void> init() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    isInternetConnected(result);
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      isInternetConnected(result);
    });
  }

  Future<bool> isInternetConnected(ConnectivityResult? result) async {
    final prefs = await SharedPreferences.getInstance();
    if (result == ConnectivityResult.none) {
      await prefs.setBool('offline_mode', true);
      isConnected.value = false;
      return false;
    } else if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          await prefs.setBool('offline_mode', false);
          isConnected.value = true;
          return true;
        }
      } on SocketException catch (_) {
        await prefs.setBool('offline_mode', true);
        isConnected.value = false;
        return false;
      }
    }
    return false;
  }
}
