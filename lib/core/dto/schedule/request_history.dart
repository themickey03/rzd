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

  factory ScheduleRequestHistory.fromJson(Map<String, dynamic> raw) {
    ScheduleRequest request = ScheduleRequest.fromJson(raw);
    return ScheduleRequestHistory(
      date: request.date,
      departureId: request.departureId,
      arrivalId: request.arrivalId,
      departure: request.departure,
      arrivalName: raw["arrivalName"] ?? "",
      departureName: raw["departureName"] ?? "",
    );
  }

  Map<String, dynamic> toJsonHistory(ScheduleRequestHistory request) {
    return {
      ...(request as ScheduleRequest).toJson(),
      "arrivalName": request.arrivalName,
      "departureName": request.departureName,
    };
  }

}