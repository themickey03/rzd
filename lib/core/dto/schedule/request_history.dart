import 'package:rzd/core/dto/schedule/request.dart';

class ScheduleRequestHistory extends ScheduleRequest {

  final String arrivalName;
  final String departureName;

  ScheduleRequestHistory({
    required this.arrivalName,
    required this.departureName,
    required super.date,
    required super.departureId,
    required super.arrivalId,
    super.departure,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is ScheduleRequestHistory &&
          runtimeType == other.runtimeType &&
          arrivalName == other.arrivalName &&
          departureName == other.departureName;

  @override
  int get hashCode => Object.hash(super.hashCode, arrivalName, departureName);

  @override
  String toString() {
    return 'ScheduleRequestHistory{${super.toString()}, arrivalName: $arrivalName, departureName: $departureName}';
  }

  factory ScheduleRequestHistory.fromJson(Map<String, dynamic> raw) {
    ScheduleRequest request = ScheduleRequest.fromJson(raw);
    ScheduleRequestHistory e = ScheduleRequestHistory(
      date: request.date,
      departureId: request.departureId,
      arrivalId: request.arrivalId,
      departure: request.departure,
      arrivalName: raw["arrivalName"] ?? "",
      departureName: raw["departureName"] ?? "",
    );
    return e;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      "arrivalName": arrivalName,
      "departureName": departureName,
    };
  }

}