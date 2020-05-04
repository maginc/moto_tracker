import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mototracker/location_tracker/location_tracker_bloc/bloc.dart';

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
      return Padding(
        padding: const EdgeInsets.all(10.0),
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
                          style: TextStyle(color: Colors.black87, fontSize: 50),
                          text: altitude.toString(),
                          children: [
                            TextSpan(text: "m", style: TextStyle(fontSize: 15))
                          ]),
                    ),
                    Text(
                      "Altitude",
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
