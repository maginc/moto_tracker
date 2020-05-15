import 'package:flutter/material.dart';
import 'package:mototracker/persistence/my_trip.dart';
import 'package:mototracker/util/settings.dart';
import 'package:mototracker/util/utilities.dart';

/// Create by Andris on 15/05/2020
class DurationDetails extends StatelessWidget {
  final MyTripEntry myTripEntry;

  const DurationDetails({Key key, this.myTripEntry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return               Card(
      child: Row(
        children: [
          Icon(
            Icons.timer,
            size: 40,
            color: Colors.black54,
          ),
          Spacer(),
          FutureBuilder(
              future:
              MySettings.getDistanceUnitsString(),
              // ignore: missing_return
              builder: (BuildContext context,
                  AsyncSnapshot<String> text) {
                if (text.hasData) {
                  return Column(
                    children: [
                      RichText(
                        text: TextSpan(
                            text:Utilities.secondsToTime(myTripEntry.duration),

                            style: TextStyle(fontSize: 30, color: Colors.black87, fontWeight: FontWeight.bold)
                        ),
                      ),
                      Text('Duration', style: TextStyle(color: Colors.black54, fontSize: 20),)
                    ],
                  );
                } else {
                  return Container(
                      width: 0.0, height: 0.0);
                }
              }),
          Spacer(),
        ],
      ),
    );
  }

}
