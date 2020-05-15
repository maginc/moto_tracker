import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mototracker/constants.dart' as Constants;
import 'package:mototracker/persistence/my_trip.dart';
import 'package:mototracker/routes/details/details_page.dart';
import 'package:mototracker/util/settings.dart';
import 'package:mototracker/util/utilities.dart';
import 'package:provider/provider.dart';

/**
 *Created by Andris on 27-Apr-20
 */
class TripList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.BACKGROUD_COLOR,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("My routes"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black87,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
        ),
      ),
      body: Column(children: [
        Expanded(
          child: _buildTaskList(context),
        )
      ]),
    );
  }

  StreamBuilder<List<MyTripEntry>> _buildTaskList(BuildContext context) {
    final database = Provider.of<TripDatabase>(context);
    return StreamBuilder(
      stream: database.watchAllTrips(),
      builder: (context, AsyncSnapshot<List<MyTripEntry>> snapshot) {


          final tripList = snapshot.data ?? List();
          final trips = tripList.reversed.toList();


        return ListView.builder(
            itemCount: trips.length,
            itemBuilder: (_, index) {
              final itemTask = trips[index];
              database.close();
              return _buildListItem(context, itemTask);
            });
      },
    );
  }

  //TODO make this look at least ok
  Widget _buildListItem(context, MyTripEntry itemTripEntry) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsPage(myTripEntry: itemTripEntry)));
      },
      child: Container(
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(children: [
              Text(
                Utilities.formatDateLog(itemTripEntry.dateAndTime),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 20,),
              Text("Duration:" +
                  Utilities.secondsToTime(itemTripEntry.duration).toString()),
              FutureBuilder(
                  future: MySettings.getDistanceUnitsString(),
                  // ignore: missing_return
                  builder: (BuildContext context, AsyncSnapshot<String> text) {
                    if (text.hasData) {
                      return Text("Distance: " +
                          Utilities.dp(
                                  Utilities.showDistance(
                                      itemTripEntry.distance, text.data),
                                  2)
                              .toString() +
                          text.data);
                    } else {
                      return Container(width: 0.0, height: 0.0);
                    }
                  }
                  ),
              Divider(
                color: Colors.redAccent,
                thickness: 1,
                endIndent: 30,
                indent: 30,
              )
            ])),
      ),
    );
  }
}
