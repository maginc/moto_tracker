import 'package:shared_preferences/shared_preferences.dart';

class MySettings {

  static Future<String> getSpeedUnitsString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('units');
    if (stringValue == "metric") {
      return 'km/h';
    } else {
      return 'mph';
    }
  }
  static Future<String> getDistanceUnitsString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('units');
    if (stringValue == "metric") {
      return 'Km';
    } else {
      return 'Mi';
    }
  }
}
