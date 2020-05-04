import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';

part 'my_trip.g.dart';

@DataClassName('MyTripEntry')
class MyTrip extends Table{

  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get dateAndTime => dateTime()();
  RealColumn get distance => real()();
  RealColumn get maxSpeed => real()();
  IntColumn get duration => integer()();
  RealColumn get averageSpeed => real()();
  TextColumn get route => text()();

}

@UseMoor(tables: [MyTrip])
class TripDatabase extends _$TripDatabase{

  TripDatabase():
      super(_openConnection());

  @override
  int get schemaVersion =>1;



  Future<List<MyTripEntry>> getAllTasks() => select(myTrip).get();
  Stream<List<MyTripEntry>> watchAllTrips() => select(myTrip).watch();

  Future insertTrip(MyTripEntry myTripEntry) => into(myTrip).insert(myTripEntry);

  Future<MyTripEntry> getTripById(int id) {
    return (select(myTrip)..where((t) => t.id.equals(id))).getSingle();
  }
  // Updates a Task with a matching primary key
  Future updateTrip(MyTripEntry myTripEntry) => update(myTrip).replace(myTripEntry);

  Future deleteTrip(MyTripEntry myTripEntry) => delete(myTrip).delete(myTripEntry);
  Future deleteTripById(int id){
    return (delete(myTrip)..where((t) => t.id.equals(id))).go();
  }
}



LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}