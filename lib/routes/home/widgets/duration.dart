import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mototracker/location_tracker/location_tracker_bloc/location_tracker_bloc.dart';
import 'package:mototracker/location_tracker/location_tracker_bloc/location_tracker_state.dart';
import 'package:mototracker/util/utilities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


/**
 *Created by Andris on 20-Apr-20
 */
class Duration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationTrackerBloc, LocationTrackerState>(
        builder: (context, state) {
          int duration = (state.currentTrip.duration == null) ? 0 : state.currentTrip.duration;

          return Padding(
            padding: const EdgeInsets.all(1),
            child: Container(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                              style: TextStyle(color: Colors.black87, fontSize: 40),
                              text: Utilities.secondsToTime(duration),
                            ),
                        ),
                        Text(
                          "Duration",
                          style: GoogleFonts.robotoMono(fontSize: 20),
                        )
                      ]),
                ),
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(width: 3.0, color: Colors.white),
              ),
            ),
          );
        });
  }
}
