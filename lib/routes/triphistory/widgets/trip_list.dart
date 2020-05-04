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
        final tasks = snapshot.data ?? List();

        return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (_, index) {
              final itemTask = tasks[index];
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
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              Text(
                Utilities.formatDateLog(itemTripEntry.dateAndTime),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text("Duration:" +
                  Utilities.secondsToTime(itemTripEntry.duration).toString()),
              FutureBuilder(
                  future: MySettings.getDistanceUnitsString(),
                  builder: (BuildContext context, AsyncSnapshot<String> text) {
                    return Text("Distance: " +
                        Utilities.dp(itemTripEntry.distance, 2).toString() +
                        text.data);
                  }),
              Divider(
                color: Colors.deepOrangeAccent,
              )
            ])),
      ),
    );
  }
}
