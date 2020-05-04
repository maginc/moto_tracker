import 'package:equatable/equatable.dart';
import 'package:mototracker/model/current_trip.dart';

abstract class LocationTrackerEvent extends Equatable {
  const LocationTrackerEvent();

  @override
  List<Object> get props => [];
}

class Start extends LocationTrackerEvent {}

class Pause extends LocationTrackerEvent {}

class Resume extends LocationTrackerEvent {}

class Save extends LocationTrackerEvent {}

class Finish extends LocationTrackerEvent {}
class LocationChange extends LocationTrackerEvent {
  final CurrentTrip currentTrip;

  LocationChange(this.currentTrip);

  @override
  List<Object> get props => [currentTrip];
}
