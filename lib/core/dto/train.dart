import 'package:intl/intl.dart';
import 'package:rzd/core/utils/utils.dart';

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

  factory Train.fromJson({required Map<String, dynamic> raw}) {
    DateTime? departure = Utils.getDateFromText(date: raw["departureDate"], time: raw["departureTime"]);
    DateTime? arrival = Utils.getDateFromText(date: raw["arrivalDate"], time: raw["arrivalTime"]);

    return Train(
      departureTime: Utils.formatTime(time: departure),
      stationType: raw["stationType"],
      railwayId: raw["railwayId"],
      departureDelayMinutes: raw["departureDelayMinutes"],
      entryId: raw["entryId"],
      trainScheduleId: raw["trainScheduleId"],
      arrivalDate: Utils.formatDate(date: arrival),
      arrivalDelayMinutes: raw["arrivalDelayMinutes"],
      departureDateAddend: raw["departureDateAddend"],
      arrivalTime: Utils.formatTime(time: arrival),
      arrivalDateAddend: raw["arrivalDateAddend"],
      traversed: raw["traversed"] == "true" || raw["traversed"] == true,
      name: raw["name"],
      departureDate: Utils.formatDate(date: departure),
      esrCode: raw["esrCode"],
      withoutStop: raw["stationType"] == "WITHOUT_STOP"
    );
  }
}