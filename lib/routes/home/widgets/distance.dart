import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mototracker/location_tracker/location_tracker_bloc/bloc.dart';
import 'package:mototracker/util/settings.dart';
import 'package:mototracker/util/utilities.dart';
import 'package:mototracker/constants.dart' as Constants;

/**
 *Created by Andris on 20-Apr-20
 */
class Distance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationTrackerBloc, LocationTrackerState>(
        builder: (context, state) {
      double distance =
          (state.currentTrip.distance == null) ? 0 : state.currentTrip.distance;

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
                      future: MySettings.getDistanceUnitsString(),
                      builder:
                          (BuildContext context, AsyncSnapshot<String> text) {
                        return RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: Constants.MAIN_TEXT_COLOR,
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -3),
                              text: _distanceTExt(
                                  Utilities.showDistance(distance, text.data)),
                              children: [
                                TextSpan(
                                    text: text.data,
                                    style: TextStyle(
                                        fontSize: 15, letterSpacing: 0.0))
                              ]),
                        );
                      }
                      ),
                  Text(
                    "Distance",
                    style: TextStyle(
                        fontFamily:'RobotoMono',
                        fontSize: 20, color: Constants.SECONDARY_TEXT_COLOR),
                  )
                ]),
          ),
        ),
        width: double.infinity,
      );
    });
  }

  String _distanceTExt(double distance) {
    if (distance < 1.0) {
      return distance.toStringAsFixed(2);
    } else if (distance > 1.0) {
      return distance.toStringAsFixed(1);
    } else {
      return distance.toInt().toString();
    }
  }
}
