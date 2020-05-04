import 'package:equatable/equatable.dart';

abstract class LocationData extends Equatable {
  final double latitude;
  final double longitude;
  final double accuracy;
  final double altitude;
  final double speed;
  final double speedAccuracy;
  final double heading;
  final double time;

  LocationData(this.latitude, this.longitude, this.accuracy, this.altitude,
      this.speed, this.speedAccuracy, this.heading, this.time);

  @override
  List<Object> get props => [latitude,longitude,accuracy,altitude, speed,speedAccuracy, heading,time];

  @override
  String toString() {
    return 'LocationData{latitude: $latitude, longitude: $longitude, accuracy: $accuracy, altitude: $altitude, speed: $speed, speedAccuracy: $speedAccuracy, heading: $heading, time: $time}';
  }


}
