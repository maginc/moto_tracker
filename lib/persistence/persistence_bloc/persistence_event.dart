import 'package:equatable/equatable.dart';
import 'package:mototracker/persistence/my_trip.dart';

abstract class PersistenceEvent extends Equatable {
  const PersistenceEvent();
  @override
  List<Object> get props => [];
}

class Save extends PersistenceEvent{
  final MyTripEntry myTripEntry;

  Save(this.myTripEntry);

  @override
  List<Object> get props => [myTripEntry];
}

class Delete extends PersistenceEvent{
  final int id;

  Delete(this.id);

  @override
  List<Object> get props => [id];
}

class GetAllTrips extends PersistenceEvent{}