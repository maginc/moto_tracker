import 'package:meta/meta.dart';
import 'package:mototracker/model/location_data.dart';

class LocationDataImpl extends LocationData {
  LocationDataImpl({
    @required double latitude,
    @required double longitude,
    @required double accuracy,
    @required double altitude,
    @required double speed,
    @required double speedAccuracy,
    @required double heading,
    @required double time
  })
      : super(latitude, longitude, accuracy, altitude, speed, speedAccuracy,
            heading, time);



}
