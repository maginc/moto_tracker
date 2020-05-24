import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

/// Create by Andris on 24/05/2020
 class MapFullScreen extends StatelessWidget {
   final List<LatLng> pointForPolyline;

  const MapFullScreen({Key key, this.pointForPolyline}) : super(key: key);
@override
Widget build(BuildContext context) {
  return Container(
    child: FlutterMap(
      options: MapOptions(
          center: pointForPolyline[
          (pointForPolyline.length / 2).toInt()],
          zoom: 13.0,
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
  );
}}
