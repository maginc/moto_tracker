import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

/// Create by Andris on 24/05/2020
class MapFullScreen extends StatelessWidget {
  final List<LatLng> pointForPolyline;

  const MapFullScreen({Key key, this.pointForPolyline}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(children: [

          Positioned(
            child: FlutterMap(
              options: MapOptions(
                  center: pointForPolyline[(pointForPolyline.length / 2).toInt()],
                  zoom: 13.0,
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
                MarkerLayerOptions(markers: [
                  Marker(
                      height: 55,
                      width: 55,
                      point: LatLng(pointForPolyline[0].latitude,
                          pointForPolyline[0].longitude),
                      builder: (ctx) => Container(
                              child: Icon(
                            Icons.location_on,
                            size: 60,
                            color: Colors.green,
                          )),
                      anchorPos: AnchorPos.align(AnchorAlign.top)
                      // anchorPos: AnchorPos.exactly(Anchor(pointForPolyline[0].latitude, pointForPolyline[0].longitude)),
                      // anchorPos: AnchorPos.align(AnchorAlign.center),
                      ),
                  Marker(
                      height: 55,
                      width: 55,
                      point: LatLng(pointForPolyline.last.latitude,
                          pointForPolyline.last.longitude),
                      builder: (ctx) => Container(
                              child: Icon(
                            Icons.beenhere,
                            size: 60,
                            color: Colors.red,
                          )),
                      anchorPos: AnchorPos.align(AnchorAlign.top)
                      // anchorPos: AnchorPos.exactly(Anchor(pointForPolyline[0].latitude, pointForPolyline[0].longitude)),
                      // anchorPos: AnchorPos.align(AnchorAlign.center),
                      ),
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
