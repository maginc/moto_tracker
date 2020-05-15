import 'package:flutter/material.dart';
import 'package:mototracker/constants.dart' as Constants;
import 'package:shared_preferences/shared_preferences.dart';

/**
 *Created by Andris on 20-Apr-20
 */
class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<bool> isSelected = [true, false];
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String _units = "";

  @override
  void initState() {
    getInitState().then((x) {
      if (x == 'metric') {
        setState(() {
          isSelected = [true, false];
          _units = 'Kilometres';
        });
      } else {
        setState(() {
          isSelected = [false, true];
          _units = 'Miles';
        });
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        Navigator.pushNamed(context, '/');
      },
      child: Scaffold(
          backgroundColor: Constants.BACKGROUD_COLOR,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text("Settings"),
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
          body: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                /*
                    Unit changer metric/imperial
                 */
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(
                                  text: _units,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal))
                            ],
                            text: "Units\n",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Spacer(),
                    ToggleButtons(
                      children: <Widget>[
                        SizedBox(
                          height: 25.0,
                          width: 100,
                          child: Center(
                              child: Text(
                            "Metric",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          )),
                        ),
                        SizedBox(
                          height: 25.0,
                          width: 100,
                          child: Center(
                              child: Text(
                            "Imperial",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          )),
                        )
                      ],
                      onPressed: (int index) {
                        setState(() {
                          for (int buttonIndex = 0;buttonIndex < isSelected.length; buttonIndex++) {
                            if (buttonIndex == index) {
                              isSelected[buttonIndex] = true;
                            } else {
                              isSelected[buttonIndex] = false;
                            }
                          }
                        });
                        setUnits();
                      },
                      isSelected: isSelected,
                      selectedColor: Colors.white,
                      fillColor: Colors.black,
                    ),

                    /*
                        More settings to be implemented
                     */
                  ],
                )
              ],
            ),
          )),
    );
  }

  Future<String> getInitState() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('units');
  }

  Future<void> setUnits() async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      if (isSelected[0] == true) {
        prefs.setString("units", 'metric');
        _units = 'Kilometres';
      } else {
        prefs.setString("units", 'imperial');
        _units = 'Miles';
      }
    });
  }
}
