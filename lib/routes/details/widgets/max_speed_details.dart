import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mototracker/persistence/my_trip.dart';
import 'package:mototracker/util/settings.dart';
import 'package:mototracker/util/utilities.dart';
import 'package:mototracker/constants.dart' as Constants;

/// Create by Andris on 15/05/2020
class MaxSpeedDetails extends StatelessWidget {
  final MyTripEntry myTripEntry;

  const MaxSpeedDetails({Key key, this.myTripEntry}) : super(key: key);

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          /*  Icon(
              Icons.av_timer,
              size: 40,
              color: Constants.BACKGROUD_COLOR,
            ),*/
         SizedBox(
           width: 30,
         ),
            SvgPicture.asset(
              'assets/max_speed.svg',
              color: Constants.ICON_COLOR,
              semanticsLabel: 'A red up arrow',
              width: 45,
              height: 45,
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
                              TextStyle(color: Constants.MAIN_TEXT_COLOR, fontSize: 35, fontWeight: FontWeight.bold),
                              text: Utilities.showSpeed(myTripEntry.maxSpeed, text.data),
                              children: [
                                TextSpan(
                                    text: text.data,
                                    style: TextStyle(fontSize: 15))
                              ]),
                        ),
                        Text('Max speed', style: TextStyle(fontSize: 15, color: Constants.SECONDARY_TEXT_COLOR),)
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
