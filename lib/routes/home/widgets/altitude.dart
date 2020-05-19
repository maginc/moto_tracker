import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mototracker/location_tracker/location_tracker_bloc/bloc.dart';
import 'package:mototracker/constants.dart' as Constants;
import 'package:mototracker/util/utilities.dart';


/**
 *Created by Andris on 20-Apr-20
 */
class Altitude extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationTrackerBloc, LocationTrackerState>(
        builder: (context, state) {
          double altitude =
          (state.currentTrip.coordinateList.last.altitude==null) ?
          0 :
          state.currentTrip.coordinateList.last.altitude;
      return Container(
        child: Card(
          color: Constants.MAIN_CARD_COLOR,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19.0),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                          style: TextStyle(color: Constants.MAIN_TEXT_COLOR, fontSize: 60,fontWeight: FontWeight.bold),
                          text: Utilities.dp(altitude, 1).toString(),
                          children: [
                            TextSpan(text: "m", style: TextStyle(fontSize: 15))
                          ]),
                    ),
                    Text(
                      "Altitude",
                      style: GoogleFonts.robotoMono(fontSize: 20, color: Constants.SECONDARY_TEXT_COLOR),
                    )
                  ]),
            ),
          ),
        ),
        width: double.infinity,

      );
    });
  }
}
