import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:mototracker/constants.dart' as Constants;
import 'package:mototracker/model/current_trip.dart';
import 'package:mototracker/persistence/my_trip.dart';
import 'package:mototracker/persistence/route.dart';

import 'package:mototracker/util/utilities.dart';
import 'package:mototracker/widgets/widgets.dart';

/**
 *Created by Andris on 30-Apr-20
 */
class ShowDetails extends StatelessWidget {
  final MyTripEntry myTripEntry;

  ShowDetails({Key key, @required this.myTripEntry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> trol = jsonDecode(myTripEntry.route);
    MyRoute route = MyRoute.fromJson(trol);
    List<LatLng> pointForPolyline = [];
    for (Coordinate coordinate in route.listOfCoordinates) {
      pointForPolyline.add(LatLng(coordinate.latitude, coordinate.longitude));
    }


    return Scaffold(
      backgroundColor: Constants.BACKGROUD_COLOR,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title:
            Text(Utilities.getDateStringFromDateTime(myTripEntry.dateAndTime)),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.black87,
                size: 30,
              ),
              onPressed: () {
                AlertDialogs.deleteTripAlertDialog(context,myTripEntry.id);
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: FlutterMap(
                options: MapOptions(
                    center: pointForPolyline[0],
                    zoom: 15.0,
                    maxZoom: 100.0,
                    minZoom: 3.0),
                layers: [
                  TileLayerOptions(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c']),
                  PolylineLayerOptions(
                    polylines: [
                      Polyline(
                          points: pointForPolyline,
                          strokeWidth: 4.0,
                          color: Colors.purple),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text("Distance: " +
                      Utilities.dp(myTripEntry.distance, 2).toString() +
                      " km"),
                  Text("Date: " + myTripEntry.dateAndTime.toIso8601String()),
                  Text("Duration: " +
                      Utilities.secondsToTime(myTripEntry.duration)),
                  Text("Max speed:" +
                      Utilities.msToKmh(myTripEntry.maxSpeed).toString() +
                      " km/h"),
                  Text("Avg speed: " +
                      Utilities.dp(myTripEntry.averageSpeed * 3.6, 2)
                          .toString() +
                      " km/h")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
