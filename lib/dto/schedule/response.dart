/// Результат фильтра
///
/// [numberRus] - Человекочитаемый номер поезда
///
/// [numberLatin] - API номер поезда
///
/// [startStation] - Станция начала движения поезда
///
/// [endStation] - Станция окончания движения поезда
///
/// [departureStation] - Станция посадки из фильтра
///
/// [arrivalStation] - Станция высадки из фильтра
class ScheduleResponse {

  final String numberRus;
  final String numberLatin;
  final ScheduleResponseStationData startStation;
  final ScheduleResponseStationData endStation;
  final ScheduleResponseStationData departureStation;
  final ScheduleResponseStationData arrivalStation;

  ScheduleResponse({
    required this.numberRus,
    required this.numberLatin,
    required this.startStation,
    required this.endStation,
    required this.departureStation,
    required this.arrivalStation,
  });

  @override
  String toString() {
    return 'ScheduleResponse{'
      'numberRus: $numberRus, '
      'numberLatin: $numberLatin, '
      'startStation: $startStation, '
      'endStation: $endStation, '
      'departureStation: $departureStation, '
      'arrivalStation: $arrivalStation}';
  }

  factory ScheduleResponse.fromJson({required Map<String, dynamic> raw}) {
    return ScheduleResponse(
      numberRus: raw["trainNumberRus"],
      numberLatin: raw["trainNumberLatin"],
      startStation: ScheduleResponseStationData.fromJson(raw: raw["trainStartStation"]),
      endStation: ScheduleResponseStationData.fromJson(raw: raw["trainEndStation"]),
      departureStation: ScheduleResponseStationData.fromJson(raw: raw["departureStation"]),
      arrivalStation: ScheduleResponseStationData.fromJson(raw: raw["arrivalStation"]),
    );
  }
}

/// Данные о станции фильтра
///
/// [name] - Название станции
///
/// [dateTime] - Время по московскому времени
///
/// [timeDiff] - Разница московского времени с локальным
class ScheduleResponseStationData {

  final String name;
  final String dateTime;
  final int timeDiff;

  ScheduleResponseStationData({
    required this.name,
    required this.dateTime,
    required this.timeDiff,
  });

  @override
  String toString() {
    return 'ScheduleResponseStationData{name: $name, dateTime: $dateTime, timeDiff: $timeDiff}';
  }

  factory ScheduleResponseStationData.fromJson({required Map<String, dynamic> raw}) {
    return ScheduleResponseStationData(
      name: raw["name"],
      dateTime: raw["moscowDateTime"],
      timeDiff: int.tryParse((raw["moscowTimeDiff"] ?? "-1").toString()) ?? -1,
    );
  }

}