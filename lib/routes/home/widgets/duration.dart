import 'package:flutter/material.dart';
import 'package:mototracker/location_tracker/location_tracker_bloc/location_tracker_bloc.dart';
import 'package:mototracker/location_tracker/location_tracker_bloc/location_tracker_state.dart';
import 'package:mototracker/util/utilities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mototracker/constants.dart' as Constants;



/**
 *Created by Andris on 20-Apr-20
 */
class DurationHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationTrackerBloc, LocationTrackerState>(
        builder: (context, state) {
          int duration = (state.currentTrip.duration == null) ? 0 : state.currentTrip.duration;

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
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: RichText(
                            text: TextSpan(
                                style: TextStyle(color: Constants.MAIN_TEXT_COLOR, fontSize: 40,fontWeight: FontWeight.bold,
                                letterSpacing: -3),
                                text: Utilities.secondsToTime(duration),
                              ),
                          ),
                        ),
                        Text(
                          "Duration",
                          style: TextStyle(
                              fontFamily:'RobotoMono',
                              fontSize: 20, color: Constants.SECONDARY_TEXT_COLOR, letterSpacing: 0.0),
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
