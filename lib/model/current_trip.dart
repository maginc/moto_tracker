class CurrentTrip {
  final List<Coordinate> coordinateList;
  final double distance;
  final double maxSpeed;
  final int duration;
  final double averageSpeed;
  final double accuracy;

  CurrentTrip(
      {this.coordinateList,
      this.distance,
      this.maxSpeed,
      this.duration,
      this.averageSpeed,
      this.accuracy});

  @override
  String toString() {
    return 'CurrentTrip{coordinateList: $coordinateList, '
        'distance: $distance, maxSpeed: $maxSpeed,'
        ' duration: $duration, averageSpeed: $averageSpeed,'
        ' accuracy: $accuracy}';
  }
}

class Coordinate {
  final double longitude;
  final double latitude;
  final double speed;
  final String timeDate;
  final double altitude;

  Coordinate(
      {this.longitude,
      this.latitude,
      this.speed,
      this.timeDate,
      this.altitude});


  @override
  String toString() {
    return 'Coordinate{ longitude: $longitude,'
        ' latitude: $latitude, speed: $speed, '
        'timeDate: $timeDate, altitude: $altitude}';
  }

  factory Coordinate.fromJson(Map<String, dynamic> parsedJson) {

    return Coordinate(
        longitude: parsedJson['longitude'],
        latitude: parsedJson['latitude'],
        speed: parsedJson['speed'],
        timeDate: parsedJson['timeDate'],
        altitude: parsedJson['altitude']);
  }

  Map<String, dynamic> toJson() => {
        '\"longitude\"': longitude,
        '\"latitude\"': latitude,
        '\"speed\"': speed,
        '\"timeDate\"': '\"' + timeDate + '\"',
        '\"altitude\"': altitude
      };
}
