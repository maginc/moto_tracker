import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:background_locator/background_locator.dart';
import 'package:background_locator/location_dto.dart';
import 'package:background_locator/location_settings.dart';
import 'package:mototracker/model/location_data_impl.dart';

import '../util/constants.dart' as Constants;

class LocationChangeListener {
  var controller = StreamController<LocationDataImpl>();
  ReceivePort port = ReceivePort();

  static void notificationCallback() {
    print('notificationCallback');
  }

  void stopLocationChangeListener(){

    port.close();
    BackgroundLocator.unRegisterLocationUpdate();
    IsolateNameServer.removePortNameMapping(Constants.ISOLATE_NAME);

  }
  void startLocationChangeListener() {

    if (IsolateNameServer.lookupPortByName(Constants.ISOLATE_NAME) != null) {
      IsolateNameServer.removePortNameMapping(Constants.ISOLATE_NAME);
    }
    port = ReceivePort();
    IsolateNameServer.registerPortWithName(
        port.sendPort, Constants.ISOLATE_NAME);

    BackgroundLocator.registerLocationUpdate(
      callback,
      androidNotificationCallback: notificationCallback,
      settings: LocationSettings(
          notificationTitle: "Moto tracker",
          notificationMsg: "Trip recording started",
          wakeLockTime: 20,
          autoStop: false,
          interval: 1),
    );
  }

  static void callback(LocationDto locationDto) async {
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

  //TODO replace this by RxDart,
  // as it's kind of looks weird when it pass "controller"
  StreamController<LocationDataImpl> location() {

    if(!controller.hasListener) {
      port.listen(
            (dynamic data) {
          controller.add(data);
        },
      );
    }

    return controller;
  }
}
