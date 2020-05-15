import 'package:flutter/material.dart';
import 'package:mototracker/persistence/my_trip.dart';
import 'package:provider/provider.dart';

import 'widgets/trip_list.dart';

/**
 *Created by Andris on 20-Apr-20
 */
class TripListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Provider<TripDatabase>(
      create: (context) => TripDatabase(),
      child: WillPopScope(
        onWillPop: () {
          return  Navigator.pushNamed(context, '/');
        },
          child: TripList()),
      dispose: (context, db) => db.close(),
    );
  }
}
