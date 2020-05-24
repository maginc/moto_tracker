import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:mototracker/constants.dart' as Constants;
import 'package:mototracker/model/current_trip.dart';
import 'package:mototracker/persistence/my_trip.dart';
import 'package:mototracker/persistence/route.dart';
import 'package:mototracker/routes/details/widgets/duration_details.dart';
import 'package:mototracker/routes/details/widgets/map_full_screen.dart';
import 'package:mototracker/util/settings.dart';
import 'package:mototracker/util/utilities.dart';
import 'package:mototracker/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'detail_widgets.dart';

/**
 *Created by Andris on 30-Apr-20
 */
class ShowDetails extends StatelessWidget {
  final MyTripEntry myTripEntry;

  ShowDetails({Key key, @required this.myTripEntry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<TripDatabase>(context);
    Map<String, dynamic> trol = jsonDecode(myTripEntry.route);
    MyRoute route = MyRoute.fromJson(trol);
    List<LatLng> pointForPolyline = [];
    for (Coordinate coordinate in route.listOfCoordinates) {
      pointForPolyline.add(LatLng(coordinate.latitude, coordinate.longitude));
    }

    return Scaffold(
      //backgroundColor: Constants.BACKGROUD_COLOR,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
       /* title:
            Text(Utilities.getDateStringFromDateTime(myTripEntry.dateAndTime)),*/
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
                AlertDialogs.deleteTripAlertDialog(
                    context, myTripEntry.id, database);
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(children: [

              Positioned(
                child: Container(
                  height: 550,
                  child: FlutterMap(
                    options: MapOptions(
                        center: pointForPolyline[
                            (pointForPolyline.length / 2).toInt()],
                        zoom: 12.0,
                        maxZoom: 100.0,
                        minZoom: 3.0),
                    layers: [
                      MarkerLayerOptions(markers: [
                        Marker(
                            width: 80.0,
                            height: 80.0,
                            point: LatLng(37.519079, -122.353722),
                            builder: (ctx) => Container(
                                  color: Colors.green,
                                  child: FlutterLogo(
                                    colors: Colors.blue,
                                  ),
                                ),
                            anchorPos: AnchorPos.align(AnchorAlign.center)
                            // anchorPos: AnchorPos.exactly(Anchor(pointForPolyline[4].latitude, pointForPolyline[4].longitude)),
                            // anchorPos: AnchorPos.align(AnchorAlign.center),
                            ),
                      ]),
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
              Positioned(
                bottom: 430,
                right: 20,
                child: IconButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MapFullScreen(pointForPolyline: pointForPolyline,)));
                  },
                  icon: Icon(Icons.fullscreen,size: 60)
                ),
              ),
              Positioned(
                height: 400,
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                      color: Constants.BACKGROUD_COLOR,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          Utilities.formatDateLog(
                              myTripEntry.dateAndTime),
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Column(
                          children: <Widget>[
                            DistanceDetails(
                              myTripEntry: myTripEntry,
                            ),
                            DurationDetails(
                              myTripEntry: myTripEntry,
                            ),
                            MaxSpeedDetails(
                              myTripEntry: myTripEntry,
                            ),
                            AverageSpeedDetails(
                              myTripEntry: myTripEntry,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
/*          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Card(
                    child: Text("Distance: " +
                        Utilities.dp(myTripEntry.distance, 2).toString() +
                        " km"),
                  ),
                  Text("Date: " + myTripEntry.dateAndTime.toIso8601String()),
                  Text("Duration: " +
                      Utilities.secondsToTime(myTripEntry.duration)),
                  Text("Max speed:" +
                      Utilities.msToKmh(myTripEntry.maxSpeed).toString() +
                      " km/h"),
                  Text("Avg speed: " +
                      Utilities.dp(myTripEntry.averageSpeed, 2).toString() +
                      " km/h")
                ],
              ),
            ),
          )*/
        ],
      ),
    );
  }
}
