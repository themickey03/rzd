/// Запрос поездов
///
/// [departure] - [date] отправления или прибытия, отправление - true
///
/// [date] - Дата фильтра
///
/// [arrivalId] - Станция прибытия
///
/// [departureId] - Станция отправления
///
class ScheduleRequest {

  final bool departure;
  final String date;
  final int departureId;
  final int arrivalId;

  ScheduleRequest({
    this.departure = true,
    required this.date,
    required this.departureId,
    required this.arrivalId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleRequest &&
          runtimeType == other.runtimeType &&
          departure == other.departure &&
          date == other.date &&
          departureId == other.departureId &&
          arrivalId == other.arrivalId;

  @override
  int get hashCode => Object.hash(departure, date, departureId, arrivalId);

  @override
  String toString() {
    return 'ScheduleRequest{departure: $departure, date: $date, departureId: $departureId, arrivalId: $arrivalId}';
  }

  factory ScheduleRequest.fromJson(Map<String, dynamic> raw) {
    return ScheduleRequest(
      departure: raw["departure"],
      date: raw["date"],
      departureId: raw["stationDepartureId"] ?? raw["departureId"],
      arrivalId: raw["stationArrivalId"] ?? raw["arrivalId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "departure": departure,
      "date": date,
      "stationDepartureId": departureId,
      "stationArrivalId": arrivalId,
    };
  }
}