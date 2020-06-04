import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:background_locator/background_locator.dart';
import 'package:background_locator/location_settings.dart';
import 'package:mototracker/model/location_data_impl.dart';

import '../util/constants.dart' as Constants;
import 'location_callback_handler.dart';

class LocationChangeListener {
  var controller = StreamController<LocationDataImpl>();
  ReceivePort port = ReceivePort();

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

    //TODO make better notification icon
    BackgroundLocator.registerLocationUpdate(
      LocationCallbackHandler.callback,
      androidNotificationCallback: LocationCallbackHandler.notificationCallback,
      settings: LocationSettings(
          notificationTitle: "Moto tracker",
          notificationMsg: "Trip is recording, press for more details",
          notificationIcon: "@drawable/notification_icon",
          wakeLockTime: 20,
          autoStop: false,
          interval: 1),
    );
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
