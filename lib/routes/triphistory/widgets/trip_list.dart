import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        child: Card(
          elevation: 2,
          color: Constants.MAIN_CARD_COLOR,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19.0),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    children: [
                  Text(
                    Utilities.formatDateLog(itemTripEntry.dateAndTime),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Constants.MAIN_TEXT_COLOR),
                  ),
                      Divider(
                        color: Colors.white,
                        indent: 60,
                        endIndent: 60,
                      ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/speed_avg4.svg',
                        color: Colors.white,
                        semanticsLabel: 'A red up arrow',
                        width: 35,
                        height: 35,
                      ),
                      Spacer(),
                      Text(
                        Utilities.secondsToTime(itemTripEntry.duration)
                            .toString(),
                        style: TextStyle(fontSize: 30, color: Colors.tealAccent),
                      ),
                      Spacer()
                    ],
                  ),
                      Divider(
                        color: Colors.white,
                        indent: 120,
                        endIndent: 100,
                      ),

                  FutureBuilder(
                      future: MySettings.getDistanceUnitsString(),
                      // ignore: missing_return
                      builder:
                          (BuildContext context, AsyncSnapshot<String> text) {
                        if (text.hasData) {
                          return Row(
                            children: [
                              SvgPicture.asset(
                                'assets/speed_avg2.svg',
                                color: Colors.white,
                                semanticsLabel: 'A red up arrow',
                                width: 35,
                                height: 35,
                              ),
                              Spacer(),
                              RichText(
                                text: TextSpan(
                                  text:Utilities.dp(
                                              Utilities.showDistance(
                                                  itemTripEntry.distance,
                                                  text.data),
                                              2)
                                          .toString(),
                                  style: TextStyle(
                                      color: Colors.tealAccent, fontSize: 30),
                                  children: [
                                    TextSpan(
                                      text: text.data,
                                      style: TextStyle(fontSize: 15, color: Colors.white)
                                    )
                                  ]
                                ),
                              ),
                              Spacer()
                            ],
                          );
                        } else {
                          return Container(width: 0.0, height: 0.0);
                        }
                      }),
                  /*    Divider(
                    color: Colors.redAccent,
                    thickness: 1,
                    endIndent: 30,
                    indent: 30,
                  )*/
                ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
