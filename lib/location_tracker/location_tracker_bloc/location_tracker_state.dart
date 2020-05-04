import 'package:equatable/equatable.dart';
import 'package:mototracker/model/current_trip.dart';
import 'package:mototracker/util/permissions.dart';

abstract class LocationTrackerState extends Equatable {
  final CurrentTrip currentTrip;

  const LocationTrackerState(this.currentTrip);

  @override
  List<Object> get props => [];
}

class InitialLocationTrackerState extends LocationTrackerState {
  final CurrentTrip currentTrip;


  InitialLocationTrackerState(this.currentTrip) : super(currentTrip);

  void check() {
    Permissions.checkLocationPermission();
    Ready(currentTrip);
  }

  @override
  List<Object> get props => [];
}

class Ready extends LocationTrackerState {
  final CurrentTrip currentTrip;

  Ready(this.currentTrip) : super(currentTrip);
}

class Paused extends LocationTrackerState {
  final CurrentTrip currentTrip;

  Paused(this.currentTrip) : super(currentTrip);
}

class Running extends LocationTrackerState {
  final CurrentTrip currentTrip;

  Running(this.currentTrip) : super(currentTrip);

  @override
  List<Object> get props => [currentTrip];
}

class Finished extends LocationTrackerState {
  final CurrentTrip currentTrip;

  Finished(this.currentTrip) : super(currentTrip);
}
