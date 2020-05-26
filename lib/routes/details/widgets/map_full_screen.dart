import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:mototracker/util/utilities.dart';

/// Create by Andris on 24/05/2020
class MapFullScreen extends StatelessWidget {
  final List<LatLng> pointForPolyline;
  final double zoom;
  const MapFullScreen({Key key, this.pointForPolyline, this.zoom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var centre = Utilities.centroid(pointForPolyline);

    return Scaffold(
      body: Container(
        child: Stack(children: [

          Positioned(
            child: FlutterMap(
              options: MapOptions(
                  center: LatLng(centre[0], centre[1]),// pointForPolyline[(pointForPolyline.length / 2).toInt()],
                  zoom: zoom,
                  maxZoom: 100.0,
                  minZoom: 3.0,
              ),
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
                MarkerLayerOptions(markers: [
                  Marker(
                      height: 25,
                      width: 40,
                      point: LatLng(pointForPolyline[0].latitude,
                          pointForPolyline[0].longitude),
                      builder: (ctx) => Container(
                              child: Icon(
                            Icons.location_on,
                            size: 30,
                            color: Colors.green,
                          )),
                      anchorPos: AnchorPos.align(AnchorAlign.top)
                      // anchorPos: AnchorPos.exactly(Anchor(pointForPolyline[0].latitude, pointForPolyline[0].longitude)),
                      // anchorPos: AnchorPos.align(AnchorAlign.center),
                      ),
                  Marker(
                      height: 25,
                      width: 45,
                      point: LatLng(pointForPolyline.last.latitude,
                          pointForPolyline.last.longitude),
                      builder: (ctx) => Container(
                              child: Icon(
                            Icons.beenhere,
                            size: 30,
                            color: Colors.red,
                          )),
                      anchorPos: AnchorPos.align(AnchorAlign.top)
                      // anchorPos: AnchorPos.exactly(Anchor(pointForPolyline[0].latitude, pointForPolyline[0].longitude)),
                      // anchorPos: AnchorPos.align(AnchorAlign.center),
                      ),
//                  Marker(
//                      height: 55,
//                      width: 55,
//                      point: LatLng(centre[0],centre[1]),
//                      builder: (ctx) => Container(
//                          child: Icon(
//                            Icons.flash_on,
//                            size: 60,
//                            color: Colors.red,
//                          )),
//                      anchorPos: AnchorPos.align(AnchorAlign.top)
//                    // anchorPos: AnchorPos.exactly(Anchor(pointForPolyline[0].latitude, pointForPolyline[0].longitude)),
//                    // anchorPos: AnchorPos.align(AnchorAlign.center),
//                  ),
                ]),
              ],
            ),
          ),
          Positioned(
            bottom: 130,
            right: 35,
            child: //Container(

              IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.fullscreen_exit,size: 60)
            ),
          ),
        ]),
      ),
    );
  }


}
