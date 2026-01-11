import 'package:intl/intl.dart';

/// Запрос поездов
///
/// [departure] - [date] отправления или прибытия
///
/// [date] - Дата фильтра
///
/// [arrivalId] - Станция отправления
///
/// [departureId] - Станция прибытия
///
class ScheduleRequest {

  final bool departure;
  final String date;
  final int arrivalId;
  final int departureId;

  ScheduleRequest({
    required this.departure,
    required this.date,
    required this.arrivalId,
    required this.departureId,
  });

  static dateToText({required DateTime date}) => DateFormat("dd.MM.yyyy").format(date);

  @override
  String toString() {
    return 'ScheduleRequest{departure: $departure, date: $date, arrivalId: $arrivalId, departureId: $departureId}';
  }

  Map<String, dynamic> toJson() {
    return {
      "departure": departure,
      "date": date,
      "stationArrivalId": arrivalId,
      "stationDepartureId": departureId,
    };
  }
}