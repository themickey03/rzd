import 'package:intl/intl.dart';

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

  static dateToText({required DateTime date}) => DateFormat("dd.MM.yyyy").format(date);

  @override
  String toString() {
    return 'ScheduleRequest{departure: $departure, date: $date, departureId: $departureId, arrivalId: $arrivalId, }';
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