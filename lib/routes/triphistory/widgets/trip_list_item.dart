import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mototracker/persistence/my_trip.dart';
import 'package:mototracker/routes/details/details_page.dart';
import 'package:mototracker/util/settings.dart';
import 'package:mototracker/util/utilities.dart';
import 'package:mototracker/constants.dart' as Constants;

/**
 *Created by Andris on 16-May-20
 */
class TripListItem extends StatelessWidget {
  final MyTripEntry myTripEntry;

  const TripListItem({Key key, this.myTripEntry}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsPage(myTripEntry: myTripEntry)));
      },
      child: Container(
        color: Colors.white,
        child: Card(
          elevation: 2,
          color: Constants.MAIN_CARD_COLOR,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19.0),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  Text(
                    Utilities.formatDateLog(myTripEntry.dateAndTime),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Constants.MAIN_TEXT_COLOR),
                  ),
                  Divider(
                    color: Colors.white,
                    indent: 60,
                    endIndent: 60,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/avg_speed.svg',
                        color: Colors.white,
                        semanticsLabel: 'A red up arrow',
                        width: 35,
                        height: 35,
                      ),
                      Spacer(),
                      Text(
                        Utilities.secondsToTime(myTripEntry.duration)
                            .toString(),
                        style:
                        TextStyle(fontSize: 30, color: Colors.tealAccent),
                      ),
                      Spacer()
                    ],
                  ),
                  Divider(
                    color: Colors.white,
                    indent: 120,
                    endIndent: 100,
                  ),
                  FutureBuilder(
                      future: MySettings.getDistanceUnitsString(),
                      // ignore: missing_return
                      builder:
                          (BuildContext context, AsyncSnapshot<String> text) {
                        if (text.hasData) {
                          return Row(
                            children: [
                              SvgPicture.asset(
                                'assets/avg_speed.svg',
                                color: Colors.white,
                                semanticsLabel: 'A red up arrow',
                                width: 35,
                                height: 35,
                              ),
                              Spacer(),
                              RichText(
                                text: TextSpan(
                                    text: Utilities.dp(
                                        Utilities.showDistance(
                                            myTripEntry.distance,
                                            text.data),
                                        2)
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.tealAccent, fontSize: 30),
                                    children: [
                                      TextSpan(
                                          text: text.data,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white))
                                    ]),
                              ),
                              Spacer()
                            ],
                          );
                        } else {
                          return Container(width: 0.0, height: 0.0);
                        }
                      }),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
