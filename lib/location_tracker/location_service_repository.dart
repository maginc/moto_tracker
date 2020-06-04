import 'dart:isolate';
import 'dart:math';
import 'dart:ui';
import 'package:background_locator/location_dto.dart';
import '../util/constants.dart' as Constants;
import 'dart:async';

import 'package:mototracker/model/models.dart';

class LocationServiceRepository {
  static LocationServiceRepository _instance = LocationServiceRepository._();

  LocationServiceRepository._();

  factory LocationServiceRepository() {
    return _instance;
  }

  static const String isolateName = Constants.ISOLATE_NAME;

  int _count = -1;


  Future<void> dispose() async {
    print("***********Dispose callback handler");
    print("$_count");
    await setLogLabel("end");
    final SendPort send = IsolateNameServer.lookupPortByName(isolateName);
    send?.send(null);
  }

  Future<void> callback(LocationDto locationDto) async {
   // print('$_count location in dart: ${locationDto.toString()}');

    final SendPort send =
    IsolateNameServer.lookupPortByName(Constants.ISOLATE_NAME);

//   This conversion is necessary in order to keep everything loose coupled

    send?.send(
        LocationDataImpl(
            latitude: locationDto.latitude,
            longitude: locationDto.longitude,
            accuracy: locationDto.accuracy,
            altitude: locationDto.altitude,
            speed: locationDto.speed,
            speedAccuracy: locationDto.speedAccuracy,
            heading: locationDto.heading,
            time: locationDto.time));

  }

  static Future<void> setLogLabel(String label) async {
    final date = DateTime.now();
    print(
        '------------\n$label: ${formatDateLog(date)}\n------------\n');
  }

  static Future<void> setLogPosition(int count, LocationDto data) async {
    final date = DateTime.now();
    print(
        '$count : ${formatDateLog(date)} --> ${formatLog(data)}\n');
  }

  static double dp(double val, int places) {
    double mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }

  static String formatDateLog(DateTime date) {
    return date.hour.toString() +
        ":" +
        date.minute.toString() +
        ":" +
        date.second.toString();
  }

  static String formatLog(LocationDto locationDto) {
    return dp(locationDto.latitude, 4).toString() +
        " " +
        dp(locationDto.longitude, 4).toString();
  }
}
