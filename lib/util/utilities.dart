import 'dart:math';

import 'package:background_locator/location_dto.dart';
import 'package:latlong/latlong.dart';
import 'package:moor/moor.dart';

class Utilities {
  static int msToKmh(double metresPerSecond) {
    return (metresPerSecond * 3.6).toInt();
  }

  static int msToMph(double metresPerSecond) {
    return (metresPerSecond * 2.23694).toInt();
  }

  static String showSpeed(double speed, String units) {
    if (units == 'km/h') {
      return Utilities.msToKmh(speed).toString();
    } else {
      return Utilities.msToMph(speed).toString();
    }
  }
  static List<double> centroid(List<LatLng> points) {
    var centroid = [ 0.0, 0.0 ];

    for (int i = 0; i < points.length; i++) {
      centroid[0] += points[i].latitude;
      centroid[1] += points[i].longitude;
    }

    int totalPoints = points.length;
    centroid[0] = centroid[0] / totalPoints;
    centroid[1] = centroid[1] / totalPoints;

    return centroid;
  }
  static double calculateZoom(double distance){
    double result = 12.0;
    if(distance<=10){
      result = 12.0;
    } else if ( distance > 10 && distance < 30){
      result = 11.0;
    } else if (distance >= 30 && distance < 100){
      result = 10.0;
    } else if (distance >=100){
      result = 9.0;
    }
    return result;
  }

  static double showDistance(double distance, String units) {
    if (units == 'Km') {
      return distance;
    } else {
      return distance / 1.609;
    }
  }

  static String secondsToTime(int seconds) {
    Duration duration = Duration(seconds: seconds);

    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  static double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  static String getDateStringFromDateTime(DateTime dateTime) {
    return dateTime.day.toString() +
        '/' +
        dateTime.month.toString() +
        '/' +
        dateTime.year.toString();
  }
  static String getTimeStringFromDateTime(DateTime dateTime) {
    return dateTime.hour.toString() +
        ':' +
        dateTime.minute.toString() +
        ':' +
        dateTime.second.toString();
  }

  static double dp(double val, int places) {
    double mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }

  static String formatDateLog(DateTime date) {
    String hour =
        date.hour >= 10 ? date.hour.toString() : "0" + date.hour.toString();
    String minute = date.minute >= 10
        ? date.minute.toString()
        : "0" + date.minute.toString();
    String second = date.second >= 10
        ? date.second.toString()
        : "0" + date.second.toString();

    return date.day.toString() +
        "/" +
        date.month.toString() +
        "/" +
        date.year.toString() +
        "       " +
        hour +
        ":" +
        minute +
        ":" +
        second;
  }

  static String formatLog(LocationDto locationDto) {
    return dp(locationDto.latitude, 4).toString() +
        " " +
        dp(locationDto.longitude, 4).toString();
  }
}
