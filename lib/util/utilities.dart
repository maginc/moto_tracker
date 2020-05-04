import 'dart:math';

import 'package:background_locator/location_dto.dart';

class Utilities {
  static int msToKmh(double metresPerSecond) {
    return (metresPerSecond * 3.6).toInt();
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

  static String getDateStringFromDateTime(DateTime dateTime){
    return dateTime.day.toString() +
        '/' +
        dateTime.month.toString() +
        '/' +
        dateTime.year.toString();
  }

  static double dp(double val, int places) {
    double mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }

  static String formatDateLog(DateTime date) {
    return date.day.toString() +
        "/" +
        date.month.toString() +
        "/" +
        date.year.toString() +
        "\n" +

      date.hour.toString() +
        ":" +
        date.minute.toString() +
        ":" +
        date.second.toString();
  }

  static String formatLog(LocationDto locationDto) {
    return dp(locationDto.latitude, 4).toString() +
        " " +
        dp(locationDto.longitude, 4).toString();
  }
}
