import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mototracker/location_tracker/location_tracker_bloc/bloc.dart';
import 'package:mototracker/util/settings.dart';
import 'package:mototracker/util/utilities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


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
                                TextStyle(color: Colors.black87, fontSize: 50),
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
                      style: GoogleFonts.robotoMono(fontSize: 20),
                    )
                  ]),
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(width: 3.0, color: Colors.white),
            ),
          );
        });
  }
}

