import 'package:flutter/material.dart';
import 'package:mototracker/persistence/my_trip.dart';
import 'package:provider/provider.dart';

import 'widgets/show_details.dart';


/**
 *Created by Andris on 28-Apr-20
 */
class DetailsPage extends StatelessWidget {
  final MyTripEntry myTripEntry;
   const DetailsPage({Key key, @required this.myTripEntry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<TripDatabase>(
      create: (context) => TripDatabase(),
      child: ShowDetails(myTripEntry: myTripEntry,),
      dispose: (context, db) => db.close(),
    );
  }

}
