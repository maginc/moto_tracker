import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

import '../../scale_route.dart';
import 'detail_widgets.dart';

/**
 *Created by Andris on 30-Apr-20
 */
class ShowDetails extends StatelessWidget {
  final MyTripEntry myTripEntry;

  ShowDetails({Key key, @required this.myTripEntry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print("SCREEN: " + MediaQuery.of(context).toString());
    final database = Provider.of<TripDatabase>(context);
    Map<String, dynamic> trol = jsonDecode(myTripEntry.route);
    MyRoute route = MyRoute.fromJson(trol);
    List<LatLng> pointForPolyline = [];
    for (Coordinate coordinate in route.listOfCoordinates) {
      pointForPolyline.add(LatLng(coordinate.latitude, coordinate.longitude));
    }
    var centre = Utilities.centroid(pointForPolyline);
    var zoom = Utilities.calculateZoom(myTripEntry.distance);

    var mapAddHeight = 85;
    if(MediaQuery.of(context).size.height < 700){
      zoom = zoom - 1.0;
      mapAddHeight = 0;
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
            child: Stack(
                children: [

              Positioned(
                child: Container(
                  height:  MediaQuery.of(context).size.height/2 + mapAddHeight,
                  child: FlutterMap(
                    options: MapOptions(
                        center: LatLng(centre[0], centre[1]),
                        zoom: zoom - 1,
                        maxZoom: 100.0,
                        minZoom: 3.0),
                    layers: [
                      TileLayerOptions(
                          urlTemplate:
                              "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                          subdomains: ['a', 'b', 'c']
                      ),
//                      TileLayerOptions(
//                        urlTemplate: "https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}",
//                        additionalOptions: {
//                          'accessToken': 'pk.eyJ1Ijoic2F1c2FnZWlza2luZyIsImEiOiJja2F0aGZxcGkwaTB0MnlvM3JqeGJtcHA1In0.S1cCmzGU-WXDQWM0yJ6NsA',
//                          'id': 'mapbox/streets-v11',
//                        },
//                      ),
                      PolylineLayerOptions(
                        polylines: [
                          Polyline(
                              points: pointForPolyline,
                              strokeWidth: 4.0,
                              color: Colors.purple),
                        ],
                      ),
                    /*  MarkerLayerOptions(
                          markers: [
                            Marker(
                                height: 30,
                                width: 50,
                                point: LatLng(
                                    pointForPolyline[0].latitude, pointForPolyline[0].longitude
                                ),
                                builder: (ctx) => Container(
                                    child: Icon(Icons.location_on, size: 20, color: Colors.green,)
                                    *//*SvgPicture.asset(
                                      'assets/startpoint.svg',
                                      color: Colors.green,
                                      semanticsLabel: 'A red up arrow',
                                      width: 50,
                                      height: 50,
                                    ),*//*
                                ),
                                anchorPos: AnchorPos.align(AnchorAlign.top)
                              // anchorPos: AnchorPos.exactly(Anchor(pointForPolyline[0].latitude, pointForPolyline[0].longitude)),
                              // anchorPos: AnchorPos.align(AnchorAlign.center),
                            ),
                            Marker(
                                height: 25,
                                width: 40,
                                point: LatLng(
                                    pointForPolyline.last.latitude, pointForPolyline.last.longitude
                                ),
                                builder: (ctx) => Container(
                                    child: Icon(Icons.adjust, size: 15, color: Colors.red,)
                               *//*     SvgPicture.asset(
                                      'assets/finishflag.svg',
                                      color: Colors.black87,
                                      semanticsLabel: 'A red up arrow',
                                      width: 55,
                                      height: 55,
                                    ),*//*
                                ),
                                anchorPos: AnchorPos.align(AnchorAlign.center)
                              // anchorPos: AnchorPos.exactly(Anchor(pointForPolyline.last.latitude, pointForPolyline.last.longitude)),
                              // anchorPos: AnchorPos.align(AnchorAlign.center),
                            ),
                          ]),*/
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 430,
                right: 25,
                child: IconButton(
                  onPressed: (){
                  /*  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MapFullScreen(pointForPolyline: pointForPolyline,)));*/
                    Navigator.push(context, ScaleRoute(page: MapFullScreen(pointForPolyline: pointForPolyline, zoom: zoom,)
                    )
                    );
                  },
                  icon: Icon(Icons.fullscreen,size: 60)
                ),
              ),
              Positioned(
                height: 385,
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
