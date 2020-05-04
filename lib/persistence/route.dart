import 'package:mototracker/model/current_trip.dart';

class MyRoute {
  final List<Coordinate> listOfCoordinates;

  MyRoute({this.listOfCoordinates});


  @override
  String toString() {
    return 'Route{ \"listOfCoordinates\": $listOfCoordinates}';
  }

  factory MyRoute.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['listOfCoordinates'] as List;
    List<Coordinate> coordinateList =
        list.map((e) => Coordinate.fromJson(e)).toList();
    return MyRoute(listOfCoordinates: coordinateList);
  }

  Map<String, dynamic> toJson() => {
        '\"listOfCoordinates\"':
            this.listOfCoordinates.map((e) => e.toJson()).toList()
      };
}
