import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mototracker/constants.dart' as Constants;
import 'package:mototracker/persistence/my_trip.dart';
import 'package:provider/provider.dart';

import 'trip_list_item.dart';

/**
 *Created by Andris on 27-Apr-20
 */
class TripList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.BACKGROUD_COLOR,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black87,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
            ),
            expandedHeight: 220.0,
            floating: true,
            pinned: true,
            snap: true,
            elevation: 2,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text('My routes',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  )),
              //background: Colors.greenAccent,
            ),
          ),
          _buildTaskList(context),
        ],
      ),
    );
  }

  _buildTaskList(BuildContext context) {
    final database = Provider.of<TripDatabase>(context);
    return StreamBuilder(
      stream: database.watchAllTrips(),
      builder: (context, AsyncSnapshot<List<MyTripEntry>> snapshot) {
        final tripList = snapshot.data ?? List();
        final trips = tripList.reversed.toList();

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              database.close();
              return TripListItem(myTripEntry: trips[index]);
            },
            childCount: trips.length,
          ),
        );
      },
    );
  }
}
