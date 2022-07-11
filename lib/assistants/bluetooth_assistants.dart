import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:fluttertoast/fluttertoast.dart';

List<ScanResult> result = [];
var chara;
late List<BluetoothService> services;
late FlutterBlue flutterBlue;

class Ble {
  static Future<void> scanPSautoconn(String deviceId) async {
    flutterBlue = FlutterBlue.instance;
    flutterBlue.startScan(
      scanMode: ScanMode.lowLatency,
      timeout: Duration(seconds: 3),
      allowDuplicates: false,
    );
    var subscription = flutterBlue.scanResults.listen((results) {
      result = results;
    });
    log(result.toString());
    //trying autoconnection
    for (var element in result) {
      if (element.device.name.startsWith("PS")) {
        try {
          await element.device.connect(timeout: Duration(seconds: 3));
          Fluttertoast.showToast(msg: "connected successfully");
        } catch (e) {
          log(e.toString());
          Fluttertoast.showToast(msg: e.toString());
        }
      }
    }
  }

  static void getServices() async {}
}
