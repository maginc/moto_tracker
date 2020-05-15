import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:mototracker/location_tracker/location_change_listener.dart';
import 'package:mototracker/model/current_trip.dart';
import 'package:mototracker/model/models.dart';
import 'package:mototracker/persistence/my_trip.dart';
import 'package:mototracker/persistence/route.dart';

import 'package:mototracker/util/utilities.dart';

import './bloc.dart';

class LocationTrackerBloc
    extends Bloc<LocationTrackerEvent, LocationTrackerState> {
  CurrentTrip initialCurrentTrip = CurrentTrip(coordinateList: [
    Coordinate(
        longitude: 0.0,
        latitude: 0.0,
        speed: 0.0,
        altitude: 0.0,
        timeDate: "2020-04-24T12:36:57Z")
  ]);

  List<Coordinate> coordinateList = [];
  double distance = 0.0;
  double maxSpeed = 0.0;
  int duration = 0;
  double averageSpeed = 0.0;

  StreamSubscription<LocationDataImpl> _tripSubscription;
  LocationChangeListener locationChangeListener = LocationChangeListener();

  LocationTrackerBloc();

  @override
  LocationTrackerState get initialState =>
      InitialLocationTrackerState(initialCurrentTrip);

  @override
  Stream<LocationTrackerState> mapEventToState(
    LocationTrackerEvent event,
  ) async* {
    if (event is Start) {
      yield* _mapStartToState(event);
    } else if (event is LocationChange) {
      yield* _mapLocationChangeToState(event.currentTrip);
    } else if (event is Pause) {
      yield* _mapPausedToState();
    } else if (event is Resume) {
      yield* _mapResumeToState();
    } else if (event is Save) {
      yield* _mapSaveToState();
    } else if (event is Finish) {
      yield* _mapFinishToState();
    }
  }

  Stream<LocationTrackerState> _mapStartToState(Start event) async* {
    yield Running(initialCurrentTrip);
    locationChangeListener.startLocationChangeListener();
    _tripSubscription?.cancel();

    /*
          duration
       */

    Stream.periodic(Duration(seconds: 1), (x) => x).listen((event) {
      duration = event;
    });

    DateTime.now().millisecond;
    /*
          get location changes
     */

    _tripSubscription =
        locationChangeListener.location().stream.listen((locationDataImpl) {
      /*
         add new coordinates to route
       */
      coordinateList.add(Coordinate(
          longitude: locationDataImpl.longitude,
          latitude: locationDataImpl.latitude,
          speed: locationDataImpl.speed,
          altitude: locationDataImpl.altitude,
          timeDate: DateTime.now().toIso8601String() //2020-04-26T12:02:40.869
          ));

      //TODO calculate maxspeed from couple consecutive values, not from one
      /*
        get maximum speed
      */
      maxSpeed =
          locationDataImpl.speed > maxSpeed ? locationDataImpl.speed : maxSpeed;

      /*
          average speed
       */
      averageSpeed = 0;

      /*
          distance calculation
       */
      if (coordinateList.length > 2) {
        distance = distance +
            Utilities.calculateDistance(
                coordinateList[coordinateList.length - 2].latitude,
                coordinateList[coordinateList.length - 2].longitude,
                coordinateList.last.latitude,
                coordinateList.last.longitude);
      }
      /*
          Average speed calculation
       */

      if (distance > 0 && duration > 0) {
        averageSpeed = (distance / duration) * 3600;

      }
      add(LocationChange(CurrentTrip(
        coordinateList: coordinateList,
        distance: distance,
        maxSpeed: maxSpeed,
        duration: duration,
        averageSpeed: averageSpeed,
      )));
    });
  }

  Stream<LocationTrackerState> _mapLocationChangeToState(
      CurrentTrip currentTrip) async* {
    yield Running(currentTrip);
  }

  Stream<LocationTrackerState> _mapPausedToState() async* {
    if (state is Running) {
      _tripSubscription?.pause();
      yield Paused(this.state.currentTrip);
    }
  }

  Stream<LocationTrackerState> _mapResumeToState() async* {
    if (state is Paused) {
      _tripSubscription?.resume();
      yield Running(this.state.currentTrip);
    }
  }

  Stream<LocationTrackerState> _mapSaveToState() async* {
    final database = TripDatabase();
    //TODO think! is there are better way to store route

    MyRoute route = MyRoute(listOfCoordinates: this.coordinateList);
    Map<String, dynamic> routeMap = route.toJson();
    String jsonString = routeMap.toString();
    final trip = MyTripEntry(
        dateAndTime: DateTime.now(),
        distance: this.distance,
        maxSpeed: this.maxSpeed,
        duration: this.duration,
        averageSpeed: this.averageSpeed,
        route: jsonString);
    database.insertTrip(trip);
    database.close();
    _tripSubscription?.cancel();
    locationChangeListener = LocationChangeListener();
    locationChangeListener.stopLocationChangeListener();
    returnMutableStatesToInitialValuesThisCodeIsFarFromBestPractices();
    yield InitialLocationTrackerState(initialCurrentTrip);
    //TODO implement cleaning old data and reset everything to initial state
  }

  //TODO replace this with proper solution, and i mean ALL this class.
  void returnMutableStatesToInitialValuesThisCodeIsFarFromBestPractices() {
    coordinateList = [];
    distance = 0.0;
    maxSpeed = 0.0;
    duration = 0;
    averageSpeed = 0.0;
  }

  Stream<LocationTrackerState> _mapFinishToState() async* {
    _tripSubscription?.cancel();
    locationChangeListener = LocationChangeListener();
    locationChangeListener.stopLocationChangeListener();
    returnMutableStatesToInitialValuesThisCodeIsFarFromBestPractices();
    yield InitialLocationTrackerState(initialCurrentTrip);
  }
}
