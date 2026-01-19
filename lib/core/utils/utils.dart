import 'package:intl/intl.dart';

import '../dto/schedule/response.dart';

class Utils {
  static String convertResponseDate({
    required ScheduleResponse e,
    required bool departure,
  }) {
    String date = departure ? e.departureStation.dateTime : e.arrivalStation.dateTime;
    date =  date.split(" ")[0];
    return convertDate(date);
  }

  static String convertDate(String date) {
    DateFormat format = DateFormat("yyyy-MM-dd");
    return format.format(convertDateTextToDateTime(date));
  }

  static DateTime convertDateTextToDateTime(String date) {
    List<String> dates = date.split(".");
    return DateTime(int.parse(dates[2]), int.parse(dates[1]), int.parse(dates[0]));
  }

  static DateTime? getDateFromText({String? date, String? time}) {

    if (date == null || time == null) return null;

    List<String> splitDate = date.split("-");
    List<String> splitTime = time.split(":");

    return DateTime(
      int.tryParse(splitDate[0]) ?? 1970,    //year
      int.tryParse(splitDate[1]) ?? 01,      //month
      int.tryParse(splitDate[2]) ?? 01,      //date
      (int.tryParse(splitTime[0]) ?? 00) + 2,    //hour
      int.tryParse(splitTime[1]) ?? 00,      //minute
      int.tryParse(splitTime[2]) ?? 0,      //second
    );
  }

  static String? formatDate({DateTime? date}) {
    if (date == null) return null;
    return DateFormat("dd.MM.yyyy").format(date);
  }

  static String? formatTime({DateTime? time}) {
    if (time == null) return null;
    return DateFormat("HH:mm").format(time);
  }
}