import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:mototracker/persistence/my_trip.dart';
import 'package:mototracker/util/settings.dart';
import 'package:mototracker/util/utilities.dart';
import 'package:mototracker/constants.dart' as Constants;


/// Create by Andris on 15/05/2020
class AverageSpeedDetails extends StatelessWidget {
  final MyTripEntry myTripEntry;

  const AverageSpeedDetails({Key key, this.myTripEntry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Constants.MAIN_CARD_COLOR,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(19.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Icon(
              Icons.access_time,
              size: 40,
              color: Constants.BACKGROUD_COLOR,
            ),


       /* SvgPicture.asset(
          'assets/avgspeed.svg',
              color: Colors.red,
              semanticsLabel: 'A red up arrow',
            width: 40,
            height: 40,
          ),*/

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
                              TextStyle(color: Constants.MAIN_TEXT_COLOR, fontSize: 30, fontWeight: FontWeight.bold),
                              text: showAvgSpeed(myTripEntry.averageSpeed, text.data),
                              children: [
                                TextSpan(
                                    text: text.data,
                                    style: TextStyle(fontSize: 15))
                              ]),
                        ),

                        Text('Average speed', style: TextStyle(fontSize: 20, color: Constants.SECONDARY_TEXT_COLOR),)
                      ],
                    );
                  } else {
                    return Container(width: 0.0, height: 0.0);
                  }
                }
                ),
            Spacer(),
          ],
        ),
      ),
    );
  }


  String showAvgSpeed(double avgSpeedKmH, String units){
    if (units == 'km/h') {
      return avgSpeedKmH.toInt().toString();
    } else {
      return (avgSpeedKmH/1.609).toInt().toString();
    }

  }
}

