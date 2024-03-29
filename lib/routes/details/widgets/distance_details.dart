import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mototracker/persistence/my_trip.dart';
import 'package:mototracker/util/settings.dart';
import 'package:mototracker/util/utilities.dart';
import 'package:mototracker/constants.dart' as Constants;

/// Create by Andris on 15/05/2020

class DistanceDetails extends StatelessWidget {
  final MyTripEntry myTripEntry;

  const DistanceDetails({Key key, this.myTripEntry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Constants.MAIN_CARD_COLOR,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(19.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
         /*   Icon(
              Icons.gps_fixed,
              size: 40,
              color: Constants.MAIN_TEXT_COLOR,
            ),*/
         SizedBox(
           width: 30,
         ),
            SvgPicture.asset(
              'assets/distance.svg',
              color: Colors.red,
              semanticsLabel: 'A red up arrow',
              width: 45,
              height: 45,
            ),
            Spacer(),
            FutureBuilder(
                future: MySettings.getDistanceUnitsString(),
                // ignore: missing_return
                builder: (BuildContext context, AsyncSnapshot<String> text) {
                  if (text.hasData) {
                    return Column(
                      children: [
                        RichText(
                          text: TextSpan(
                              text: Utilities.dp(
                                      Utilities.showDistance(
                                          myTripEntry.distance, text.data),
                                      2)
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 35,
                                  color: Constants.MAIN_TEXT_COLOR,
                                  fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                    text: text.data,
                                    style: TextStyle(fontSize: 15))
                              ]),
                        ),
                        Text(
                          'Distance',
                          style: TextStyle(fontSize: 15, color: Constants.SECONDARY_TEXT_COLOR),
                        )
                      ],
                    );
                  } else {
                    return Container(width: 0.0, height: 0.0);
                  }
                }),
            Spacer(flex: 2,),
          ],
        ),
      ),
    );
  }
}
