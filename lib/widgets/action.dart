
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mototracker/location_tracker/location_tracker_bloc/bloc.dart';

class Controls extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: _mapStateToActionButtons(
      locationTrackerBloc: BlocProvider.of<LocationTrackerBloc>(context),
    ),
  );
}

List<Widget> _mapStateToActionButtons({LocationTrackerBloc locationTrackerBloc}) {
  final LocationTrackerState currentState = locationTrackerBloc.state;
  if (currentState is InitialLocationTrackerState) {
    return [
      FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () =>
            locationTrackerBloc.add(Start()),
      ),
    ];
  }
  if (currentState is Running) {
    return [
      FloatingActionButton(
        child: Icon(Icons.pause),
        onPressed: () => locationTrackerBloc.add(Pause()),
      ),
      FloatingActionButton(
        child: Icon(Icons.replay),
        onPressed: () => locationTrackerBloc.add(Save()),
      ),
    ];
  }
  if (currentState is Paused) {
    return [
      FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () => locationTrackerBloc.add(Resume()),
      ),
      FloatingActionButton(
        child: Icon(Icons.replay),
        onPressed: () => locationTrackerBloc.add(Save()),
      ),
    ];
  }
  if (currentState is Finished) {
    return [
      FloatingActionButton(
        child: Icon(Icons.replay),
        onPressed: () => locationTrackerBloc.add(Save()),
      ),
    ];
  }
  return [];
}
}