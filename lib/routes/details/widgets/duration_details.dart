import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mototracker/persistence/my_trip.dart';
import 'package:mototracker/util/settings.dart';
import 'package:mototracker/util/utilities.dart';
import 'package:mototracker/constants.dart' as Constants;

/// Create by Andris on 15/05/2020
class DurationDetails extends StatelessWidget {
  final MyTripEntry myTripEntry;

  const DurationDetails({Key key, this.myTripEntry}) : super(key: key);

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
          children: [
           /* Icon(
              Icons.timer,
              size: 40,
              color: Constants.BACKGROUD_COLOR,
            ),*/
            SvgPicture.asset(
              'assets/avg_speed.svg',
              color: Colors.white,
              semanticsLabel: 'A red up arrow',
              width: 50,
              height: 50,
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
                              text: Utilities.secondsToTime(myTripEntry.duration),
                              style: TextStyle(
                                  fontSize: 35,
                                  color: Constants.MAIN_TEXT_COLOR,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Text(
                          'Duration',
                          style: TextStyle(color: Constants.SECONDARY_TEXT_COLOR, fontSize: 15),
                        )
                      ],
                    );
                  } else {
                    return Container(width: 0.0, height: 0.0);
                  }
                }),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
