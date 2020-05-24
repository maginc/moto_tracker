// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_trip.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class MyTripEntry extends DataClass implements Insertable<MyTripEntry> {
  final int id;
  final DateTime dateAndTime;
  final double distance;
  final double maxSpeed;
  final int duration;
  final double averageSpeed;
  final String route;
  MyTripEntry(
      {@required this.id,
      @required this.dateAndTime,
      @required this.distance,
      @required this.maxSpeed,
      @required this.duration,
      @required this.averageSpeed,
      @required this.route});
  factory MyTripEntry.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final doubleType = db.typeSystem.forDartType<double>();
    final stringType = db.typeSystem.forDartType<String>();
    return MyTripEntry(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      dateAndTime: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}date_and_time']),
      distance: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}distance']),
      maxSpeed: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}max_speed']),
      duration:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}duration']),
      averageSpeed: doubleType
          .mapFromDatabaseResponse(data['${effectivePrefix}average_speed']),
      route:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}route']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || dateAndTime != null) {
      map['date_and_time'] = Variable<DateTime>(dateAndTime);
    }
    if (!nullToAbsent || distance != null) {
      map['distance'] = Variable<double>(distance);
    }
    if (!nullToAbsent || maxSpeed != null) {
      map['max_speed'] = Variable<double>(maxSpeed);
    }
    if (!nullToAbsent || duration != null) {
      map['duration'] = Variable<int>(duration);
    }
    if (!nullToAbsent || averageSpeed != null) {
      map['average_speed'] = Variable<double>(averageSpeed);
    }
    if (!nullToAbsent || route != null) {
      map['route'] = Variable<String>(route);
    }
    return map;
  }

  MyTripCompanion toCompanion(bool nullToAbsent) {
    return MyTripCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      dateAndTime: dateAndTime == null && nullToAbsent
          ? const Value.absent()
          : Value(dateAndTime),
      distance: distance == null && nullToAbsent
          ? const Value.absent()
          : Value(distance),
      maxSpeed: maxSpeed == null && nullToAbsent
          ? const Value.absent()
          : Value(maxSpeed),
      duration: duration == null && nullToAbsent
          ? const Value.absent()
          : Value(duration),
      averageSpeed: averageSpeed == null && nullToAbsent
          ? const Value.absent()
          : Value(averageSpeed),
      route:
          route == null && nullToAbsent ? const Value.absent() : Value(route),
    );
  }

  factory MyTripEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MyTripEntry(
      id: serializer.fromJson<int>(json['id']),
      dateAndTime: serializer.fromJson<DateTime>(json['dateAndTime']),
      distance: serializer.fromJson<double>(json['distance']),
      maxSpeed: serializer.fromJson<double>(json['maxSpeed']),
      duration: serializer.fromJson<int>(json['duration']),
      averageSpeed: serializer.fromJson<double>(json['averageSpeed']),
      route: serializer.fromJson<String>(json['route']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dateAndTime': serializer.toJson<DateTime>(dateAndTime),
      'distance': serializer.toJson<double>(distance),
      'maxSpeed': serializer.toJson<double>(maxSpeed),
      'duration': serializer.toJson<int>(duration),
      'averageSpeed': serializer.toJson<double>(averageSpeed),
      'route': serializer.toJson<String>(route),
    };
  }

  MyTripEntry copyWith(
          {int id,
          DateTime dateAndTime,
          double distance,
          double maxSpeed,
          int duration,
          double averageSpeed,
          String route}) =>
      MyTripEntry(
        id: id ?? this.id,
        dateAndTime: dateAndTime ?? this.dateAndTime,
        distance: distance ?? this.distance,
        maxSpeed: maxSpeed ?? this.maxSpeed,
        duration: duration ?? this.duration,
        averageSpeed: averageSpeed ?? this.averageSpeed,
        route: route ?? this.route,
      );
  @override
  String toString() {
    return (StringBuffer('MyTripEntry(')
          ..write('id: $id, ')
          ..write('dateAndTime: $dateAndTime, ')
          ..write('distance: $distance, ')
          ..write('maxSpeed: $maxSpeed, ')
          ..write('duration: $duration, ')
          ..write('averageSpeed: $averageSpeed, ')
          ..write('route: $route')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          dateAndTime.hashCode,
          $mrjc(
              distance.hashCode,
              $mrjc(
                  maxSpeed.hashCode,
                  $mrjc(duration.hashCode,
                      $mrjc(averageSpeed.hashCode, route.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is MyTripEntry &&
          other.id == this.id &&
          other.dateAndTime == this.dateAndTime &&
          other.distance == this.distance &&
          other.maxSpeed == this.maxSpeed &&
          other.duration == this.duration &&
          other.averageSpeed == this.averageSpeed &&
          other.route == this.route);
}

class MyTripCompanion extends UpdateCompanion<MyTripEntry> {
  final Value<int> id;
  final Value<DateTime> dateAndTime;
  final Value<double> distance;
  final Value<double> maxSpeed;
  final Value<int> duration;
  final Value<double> averageSpeed;
  final Value<String> route;
  const MyTripCompanion({
    this.id = const Value.absent(),
    this.dateAndTime = const Value.absent(),
    this.distance = const Value.absent(),
    this.maxSpeed = const Value.absent(),
    this.duration = const Value.absent(),
    this.averageSpeed = const Value.absent(),
    this.route = const Value.absent(),
  });
  MyTripCompanion.insert({
    this.id = const Value.absent(),
    @required DateTime dateAndTime,
    @required double distance,
    @required double maxSpeed,
    @required int duration,
    @required double averageSpeed,
    @required String route,
  })  : dateAndTime = Value(dateAndTime),
        distance = Value(distance),
        maxSpeed = Value(maxSpeed),
        duration = Value(duration),
        averageSpeed = Value(averageSpeed),
        route = Value(route);
  static Insertable<MyTripEntry> custom({
    Expression<int> id,
    Expression<DateTime> dateAndTime,
    Expression<double> distance,
    Expression<double> maxSpeed,
    Expression<int> duration,
    Expression<double> averageSpeed,
    Expression<String> route,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dateAndTime != null) 'date_and_time': dateAndTime,
      if (distance != null) 'distance': distance,
      if (maxSpeed != null) 'max_speed': maxSpeed,
      if (duration != null) 'duration': duration,
      if (averageSpeed != null) 'average_speed': averageSpeed,
      if (route != null) 'route': route,
    });
  }

  MyTripCompanion copyWith(
      {Value<int> id,
      Value<DateTime> dateAndTime,
      Value<double> distance,
      Value<double> maxSpeed,
      Value<int> duration,
      Value<double> averageSpeed,
      Value<String> route}) {
    return MyTripCompanion(
      id: id ?? this.id,
      dateAndTime: dateAndTime ?? this.dateAndTime,
      distance: distance ?? this.distance,
      maxSpeed: maxSpeed ?? this.maxSpeed,
      duration: duration ?? this.duration,
      averageSpeed: averageSpeed ?? this.averageSpeed,
      route: route ?? this.route,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dateAndTime.present) {
      map['date_and_time'] = Variable<DateTime>(dateAndTime.value);
    }
    if (distance.present) {
      map['distance'] = Variable<double>(distance.value);
    }
    if (maxSpeed.present) {
      map['max_speed'] = Variable<double>(maxSpeed.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (averageSpeed.present) {
      map['average_speed'] = Variable<double>(averageSpeed.value);
    }
    if (route.present) {
      map['route'] = Variable<String>(route.value);
    }
    return map;
  }
}

class $MyTripTable extends MyTrip with TableInfo<$MyTripTable, MyTripEntry> {
  final GeneratedDatabase _db;
  final String _alias;
  $MyTripTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _dateAndTimeMeta =
      const VerificationMeta('dateAndTime');
  GeneratedDateTimeColumn _dateAndTime;
  @override
  GeneratedDateTimeColumn get dateAndTime =>
      _dateAndTime ??= _constructDateAndTime();
  GeneratedDateTimeColumn _constructDateAndTime() {
    return GeneratedDateTimeColumn(
      'date_and_time',
      $tableName,
      false,
    );
  }

  final VerificationMeta _distanceMeta = const VerificationMeta('distance');
  GeneratedRealColumn _distance;
  @override
  GeneratedRealColumn get distance => _distance ??= _constructDistance();
  GeneratedRealColumn _constructDistance() {
    return GeneratedRealColumn(
      'distance',
      $tableName,
      false,
    );
  }

  final VerificationMeta _maxSpeedMeta = const VerificationMeta('maxSpeed');
  GeneratedRealColumn _maxSpeed;
  @override
  GeneratedRealColumn get maxSpeed => _maxSpeed ??= _constructMaxSpeed();
  GeneratedRealColumn _constructMaxSpeed() {
    return GeneratedRealColumn(
      'max_speed',
      $tableName,
      false,
    );
  }

  final VerificationMeta _durationMeta = const VerificationMeta('duration');
  GeneratedIntColumn _duration;
  @override
  GeneratedIntColumn get duration => _duration ??= _constructDuration();
  GeneratedIntColumn _constructDuration() {
    return GeneratedIntColumn(
      'duration',
      $tableName,
      false,
    );
  }

  final VerificationMeta _averageSpeedMeta =
      const VerificationMeta('averageSpeed');
  GeneratedRealColumn _averageSpeed;
  @override
  GeneratedRealColumn get averageSpeed =>
      _averageSpeed ??= _constructAverageSpeed();
  GeneratedRealColumn _constructAverageSpeed() {
    return GeneratedRealColumn(
      'average_speed',
      $tableName,
      false,
    );
  }

  final VerificationMeta _routeMeta = const VerificationMeta('route');
  GeneratedTextColumn _route;
  @override
  GeneratedTextColumn get route => _route ??= _constructRoute();
  GeneratedTextColumn _constructRoute() {
    return GeneratedTextColumn(
      'route',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, dateAndTime, distance, maxSpeed, duration, averageSpeed, route];
  @override
  $MyTripTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'my_trip';
  @override
  final String actualTableName = 'my_trip';
  @override
  VerificationContext validateIntegrity(Insertable<MyTripEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('date_and_time')) {
      context.handle(
          _dateAndTimeMeta,
          dateAndTime.isAcceptableOrUnknown(
              data['date_and_time'], _dateAndTimeMeta));
    } else if (isInserting) {
      context.missing(_dateAndTimeMeta);
    }
    if (data.containsKey('distance')) {
      context.handle(_distanceMeta,
          distance.isAcceptableOrUnknown(data['distance'], _distanceMeta));
    } else if (isInserting) {
      context.missing(_distanceMeta);
    }
    if (data.containsKey('max_speed')) {
      context.handle(_maxSpeedMeta,
          maxSpeed.isAcceptableOrUnknown(data['max_speed'], _maxSpeedMeta));
    } else if (isInserting) {
      context.missing(_maxSpeedMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration'], _durationMeta));
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('average_speed')) {
      context.handle(
          _averageSpeedMeta,
          averageSpeed.isAcceptableOrUnknown(
              data['average_speed'], _averageSpeedMeta));
    } else if (isInserting) {
      context.missing(_averageSpeedMeta);
    }
    if (data.containsKey('route')) {
      context.handle(
          _routeMeta, route.isAcceptableOrUnknown(data['route'], _routeMeta));
    } else if (isInserting) {
      context.missing(_routeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MyTripEntry map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return MyTripEntry.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $MyTripTable createAlias(String alias) {
    return $MyTripTable(_db, alias);
  }
}

abstract class _$TripDatabase extends GeneratedDatabase {
  _$TripDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $MyTripTable _myTrip;
  $MyTripTable get myTrip => _myTrip ??= $MyTripTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [myTrip];
}
