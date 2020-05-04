import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mototracker/location_tracker/location_tracker_bloc/bloc.dart';
import 'package:mototracker/routes/triphistory/trip_list_page.dart';
import 'package:mototracker/constants.dart' as Constants;
import 'package:mototracker/widgets/alert_dialogs.dart';

import '../settings/settings_page.dart';
import 'widgets/widgets.dart';

/**
 *Created by Andris on 20-Apr-20
 */

//TODO review how gui is made, remove unnecessary widget nesting
class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    const separatorLineColor = Colors.teal;
    return Scaffold(
        backgroundColor: Constants.BACKGROUD_COLOR,
        appBar: AppBar(
          //backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                Icons.event,
                color: Colors.black87,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TripListPage()),
                );
              },
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(
                  Icons.tune,
                  color: Colors.black87,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                },
              ),
            ),
          ],
        ),

        body: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 200,
                        child: CurrentSpeed(),
                      ),
                    ),
                    VerticalDivider(
                      thickness: 1,
                      color: separatorLineColor,
                      indent: 20,
                      endIndent: 0,
                    ),
                    Expanded(
                      child: Container(height: 200, child: Distance()),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 1,
              color: separatorLineColor,
              indent: 20,
              endIndent: 20,
            ),
            Expanded(
              flex: 3,
              child: Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 200,
                        child: Altitude(),
                      ),
                    ),
                    VerticalDivider(
                      thickness: 1,
                      color: separatorLineColor,
                      indent: 0,
                      endIndent: 0,
                    ),
                    Expanded(
                      child: Container(height: 200, child: Duration()),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 1,
              color: separatorLineColor,
              indent: 20,
              endIndent: 20,
            ),
            Expanded(
              flex: 3,
              child: Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(height: 200, child: MaxSpeed()),
                    ),
                    VerticalDivider(
                      thickness: 1,
                      color: separatorLineColor,
                      indent: 0,
                      endIndent: 20,
                    ),
                    Expanded(
                      child: Container(
                        height: 200,
                        child: AvgSpeed(),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Spacer()
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          shape: const CircularNotchedRectangle(),
          child: Container(
            height: 70.0,
          ),
        ),
        floatingActionButton:
            BlocBuilder<LocationTrackerBloc, LocationTrackerState>(
          condition: (previousState, state) =>
              state.runtimeType != previousState.runtimeType,
          builder: (context, state) => _mapStateToActionButtons(
              locationTrackerBloc:
                  BlocProvider.of<LocationTrackerBloc>(context),
              context: context),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked);
  }

//TODO move controls to another file
  _mapStateToActionButtons(
      {LocationTrackerBloc locationTrackerBloc, BuildContext context}) {
    final LocationTrackerState currentState = locationTrackerBloc.state;
    if (currentState is InitialLocationTrackerState) {
      return Container(
        height: 140,
        width: 140,
        child: FittedBox(
          child: FloatingActionButton.extended(
            backgroundColor: Colors.red,
            icon: Icon(
              Icons.play_arrow,
              size: 40,
            ),
            label: Text("GO!"),
            onPressed: () => locationTrackerBloc.add(Start()),
          ),
        ),
      );
    }
    if (currentState is Running) {
      return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Spacer(),
        Container(
          height: 80,
          width: 80,
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: Colors.green,
              child: Icon(Icons.pause),
              onPressed: () => locationTrackerBloc.add(Pause()),
            ),
          ),
        ),
        Spacer(),
        Container(
          height: 80,
          width: 80,
          child: FittedBox(
            child: FloatingActionButton(
                backgroundColor: Colors.red,
                child: Icon(
                  Icons.stop,
                  color: Colors.black87,
                ),
                onPressed: () => AlertDialogs.saveTripAlertDialog(context, locationTrackerBloc)),
          ),
        ),
        Spacer()
      ]);
    }
    if (currentState is Paused) {
      return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Spacer(),
        Container(
          height: 80,
          width: 80,
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: Colors.green,
              child: Icon(Icons.play_arrow),
              onPressed: () => locationTrackerBloc.add(Resume()),
            ),
          ),
        ),
        Spacer(),
        Container(
          height: 80,
          width: 80,
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              child: Icon(
                Icons.stop,
                color: Colors.black87,
              ),
              onPressed: () => AlertDialogs.saveTripAlertDialog(context, locationTrackerBloc),
            ),
          ),
        ),
        Spacer()
      ]);
    }
    if (currentState is Finished) {
      return [
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => locationTrackerBloc.add(Save()),
        ),
      ];
    }
    return [];
  }
}
