import 'package:flutter/material.dart';
import 'package:mototracker/location_tracker/location_tracker_bloc/bloc.dart';
import 'package:mototracker/persistence/my_trip.dart';
import 'package:provider/provider.dart';
import 'package:mototracker/constants.dart' as Constants;



//TODO make use of bloc for database operations
/**
 *Created by Andris on 02-May-20
 */
class AlertDialogs {

  static Future<void> deleteTripAlertDialog(context, int id, database) async{
    var myColor = Colors.deepOrange;
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Constants.BACKGROUD_COLOR,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 25.0,
                    child: Center(
                        child: Text(
                          "Delte this trip?",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, color: Constants.MAIN_TEXT_COLOR),
                        )),
                  ),
                  Divider(
                    color: Colors.white,
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          color: Constants.MAIN_CARD_COLOR
                      ),
                      child: SizedBox(
                        height: 150,
                        child: Padding(
                            padding: EdgeInsets.all(40.0),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: "Are you sure want to delete this trip?",
                                  style: TextStyle(
                                    //fontWeight: FontWeight.bold,
                                      color: Constants.MAIN_TEXT_COLOR, fontSize: 20)),
                            )),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            database.deleteTripById(id);
                            database.close();
                            Navigator.pushNamed(context, '/trip_list_page');


                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                            decoration: BoxDecoration(
                              color: myColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15.0),
                                // bottomRight: Radius.circular(32.0)
                              ),
                            ),
                            child: Text(
                              "Delete",
                              style: TextStyle(color: Colors.white, fontSize: 25),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => Navigator.of(context, rootNavigator: true).pop('dialog'),
                          child: Container(
                            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.only(
                                //bottomLeft: Radius.circular(32.0),
                                  bottomRight: Radius.circular(15.0)),
                            ),
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: Colors.white, fontSize: 25),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }


  /*
              Save trip alert box
   */
  static Future<void> saveTripAlertDialog(context, locationTrackerBloc) async {
    var myColor = Colors.red;
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Constants.BACKGROUD_COLOR,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 25.0,
                    child: Center(
                        child: Text(
                          "Save current trip?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25.0, color: Constants.MAIN_TEXT_COLOR),
                        )),
                  ),
                  Divider(
                    color: Colors.white,
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                       // border: Border.all(),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        color: Constants.MAIN_CARD_COLOR
                      ),
                      child: SizedBox(
                        height: 150,
                        child: Padding(
                            padding: EdgeInsets.only(left: 30.0, right: 30.0),
                            child: Center(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: "Trip will be finished \n",
                                    style: TextStyle(
                                      //fontWeight: FontWeight.bold,
                                        color: Constants.MAIN_TEXT_COLOR, fontSize: 25, )
                                    ,
                                    children: [
                                      TextSpan(text: "and saved!")
                                    ]
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            locationTrackerBloc.add(Finish());
                            Navigator.of(context, rootNavigator: true).pop(
                                'dialog');
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                            decoration: BoxDecoration(
                              color: myColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15.0),
                                // bottomRight: Radius.circular(32.0)
                              ),
                            ),
                            child: Text(
                              "Discard",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 25),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            locationTrackerBloc.add(Save());
                            Navigator.of(context, rootNavigator: true).pop(
                                'dialog');
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.only(
                                //bottomLeft: Radius.circular(32.0),
                                  bottomRight: Radius.circular(15.0)),
                            ),
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 25),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

}