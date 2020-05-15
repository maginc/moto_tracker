import 'package:flutter/material.dart';
import 'package:mototracker/persistence/my_trip.dart';
import 'package:mototracker/util/settings.dart';
import 'package:mototracker/util/utilities.dart';

/// Create by Andris on 15/05/2020
class MaxSpeedDetails extends StatelessWidget {
  final MyTripEntry myTripEntry;

  const MaxSpeedDetails({Key key, this.myTripEntry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Icon(
            Icons.av_timer,
            size: 40,
            color: Colors.black54,
          ),
          Spacer(),
          FutureBuilder(
              future: MySettings.getSpeedUnitsString(),
              // ignore: missing_return
              builder: (BuildContext context, AsyncSnapshot<String> text) {
                if (text.hasData) {
                  return Column(
                    children: [
                      RichText(
                        text: TextSpan(
                            style:
                            TextStyle(color: Colors.black87, fontSize: 30, fontWeight: FontWeight.bold),
                            text: Utilities.showSpeed(myTripEntry.maxSpeed, text.data),
                            children: [
                              TextSpan(
                                  text: text.data,
                                  style: TextStyle(fontSize: 15))
                            ]),
                      ),
                      Text('Max speed', style: TextStyle(fontSize: 20, color: Colors.black54),)
                    ],
                  );
                } else {
                  return Container(width: 0.0, height: 0.0);
                }
              }),
          Spacer(),
        ],
      ),
    );
  }
}
