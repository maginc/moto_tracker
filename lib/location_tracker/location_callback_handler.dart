import 'dart:async';
import 'package:background_locator/location_dto.dart';
import 'location_service_repository.dart';

class LocationCallbackHandler {


  static Future<void> disposeCallback() async {
    LocationServiceRepository myLocationCallbackRepository =
        LocationServiceRepository();
    await myLocationCallbackRepository.dispose();
  }

  static Future<void> callback(LocationDto locationDto) async {
    LocationServiceRepository myLocationCallbackRepository =
        LocationServiceRepository();
    await myLocationCallbackRepository.callback(locationDto);
  }

  static Future<void> notificationCallback() async {
    print('***LUUUUULLZZLZLZLz zlzlzlzlzzzLLZLZ !!!!');
  }
}
