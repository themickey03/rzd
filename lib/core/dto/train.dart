import 'package:intl/intl.dart';

/// Актуальное состояние поезда
class Train {

  final String? departureTime;
  final String? stationType;
  final int? railwayId;
  final int? departureDelayMinutes;
  final int? entryId;
  final int? trainScheduleId;
  final String? arrivalDate;
  final int? arrivalDelayMinutes;
  final int? departureDateAddend;
  final String? arrivalTime;
  final int? arrivalDateAddend;
  final bool? traversed;
  final String? name;
  final String? departureDate;
  final int? esrCode;
  final bool? withoutStop;

  Train({
    this.departureTime,
    this.stationType,
    this.railwayId,
    this.departureDelayMinutes,
    this.entryId,
    this.trainScheduleId,
    this.arrivalDate,
    this.arrivalDelayMinutes,
    this.departureDateAddend,
    this.arrivalTime,
    this.arrivalDateAddend,
    this.traversed,
    this.name,
    this.departureDate,
    this.esrCode,
    this.withoutStop,
  });
  
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

  factory Train.fromJson({required Map<String, dynamic> raw}) {
    DateTime? departure = getDateFromText(date: raw["departureDate"], time: raw["departureTime"]);
    DateTime? arrival = getDateFromText(date: raw["arrivalDate"], time: raw["arrivalTime"]);

    return Train(
      departureTime: formatTime(time: departure),
      stationType: raw["stationType"],
      railwayId: raw["railwayId"],
      departureDelayMinutes: raw["departureDelayMinutes"],
      entryId: raw["entryId"],
      trainScheduleId: raw["trainScheduleId"],
      arrivalDate: formatDate(date: arrival),
      arrivalDelayMinutes: raw["arrivalDelayMinutes"],
      departureDateAddend: raw["departureDateAddend"],
      arrivalTime: formatTime(time: arrival),
      arrivalDateAddend: raw["arrivalDateAddend"],
      traversed: raw["traversed"] == "true" || raw["traversed"] == true,
      name: raw["name"],
      departureDate: formatDate(date: departure),
      esrCode: raw["esrCode"],
      withoutStop: raw["stationType"] == "WITHOUT_STOP"
    );
  }
}