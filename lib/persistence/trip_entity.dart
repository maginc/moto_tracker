import 'package:json_annotation/json_annotation.dart' as j;
import 'package:mototracker/model/current_trip.dart';

import 'route.dart';

class TripEntity {
  final MyRoute route;
  final double distance;
  final double maxSpeed;
  final int duration;
  final double averageSpeed;
  final double accuracy;

  TripEntity(
      {
        this.route,
        this.distance,
        this.maxSpeed,
        this.duration,
        this.averageSpeed,
        this.accuracy});



  @override
  String toString() {
    return 'CurrentTrip{coordinateList: $route, distance: $distance, maxSpeed: $maxSpeed, duration: $duration, averageSpeed: $averageSpeed, accuracy: $accuracy}';
  }
}


