import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mototracker/location_tracker/location_tracker_bloc/bloc.dart';
import 'package:mototracker/util/settings.dart';
import 'package:mototracker/util/utilities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mototracker/constants.dart' as Constants;



/**
 *Created by Andris on 20-Apr-20
 */
class MaxSpeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationTrackerBloc, LocationTrackerState>(
        builder: (context, state) {
          double maxSpeed = (state.currentTrip.maxSpeed == null) ? 0 : state.currentTrip.maxSpeed;

          return Container(
            child: Card(
              color: Constants.MAIN_CARD_COLOR,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(19.0),
              ),
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FutureBuilder(
                          future: MySettings.getSpeedUnitsString(),
                          builder:
                              (BuildContext context, AsyncSnapshot<String> text) {
                            return RichText(
                              text: TextSpan(
                                  style:
                                  TextStyle(color: Constants.MAIN_TEXT_COLOR, fontSize: 60,fontWeight: FontWeight.bold),
                                  text: Utilities.showSpeed(maxSpeed, text.data),
                                  children: [
                                    TextSpan(
                                        text: text.data,
                                        style: TextStyle(fontSize: 15))
                                  ]),
                            );
                          }),
                      Text(
                        "Max Speed",
                        style: GoogleFonts.robotoMono(fontSize: 20, color: Constants.SECONDARY_TEXT_COLOR),
                      )
                    ]),
              ),
            ),
            width: double.infinity,

          );
        });
  }
}

