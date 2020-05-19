import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      body: Container(
        color: Constants.BACKGROUD_COLOR,
        child: CustomScrollView(
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
                elevation: 1,
                backgroundColor: Constants.BACKGROUD_COLOR,

                flexibleSpace: FlexibleSpaceBar(
                  title: Text('My rides'),
                  titlePadding: const EdgeInsets.only(bottom: 8.0),
                  centerTitle: true,
                  collapseMode: CollapseMode.parallax,
//                background: Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: <Widget>[
//                      Container(
//                          margin: EdgeInsets.only(top: 16.0),
//                          padding: EdgeInsets.only(left: 32.0, right: 32.0),
//                          child: Text(
//                            'Distance driven : 4320km',
//                            textAlign: TextAlign.center,
//                            style: TextStyle(
//                                color: Colors.black87,
//                                fontFamily: 'PlayfairDisplay',
//                                fontStyle: FontStyle.italic,
//                                fontSize: 16.0),
//                          )),
//                      Container(
//                        margin: EdgeInsets.only(top: 16.0),
//                        padding: EdgeInsets.only(left: 32.0, right: 32.0),
//                        child: Text(
//                          'Time on road spend: 234:45:53',
//                          textAlign: TextAlign.center,
//                          style: TextStyle(
//                              color: Colors.black87,
//                              fontFamily: 'PlayfairDisplay',
//                              fontSize: 16.0),
//                        ),
//                      ),
//                    ]
//                ),
                )
            ),

            _buildTaskList(context),
          ],
        ),
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
