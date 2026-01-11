import 'package:dio/dio.dart';

import '../dto/destination.dart';
import '../dto/schedule/request.dart';
import '../dto/schedule/response.dart';
import '../dto/train.dart';

class RzdService {

  Dio dio = Dio();
  String baseUrl = "https://www.rzd.ru";

  RzdService();

  Stream<List<Train>> getTrainData({required String station, required String date}) {
    return dio.get("$baseUrl/routemap/source/current/train/$station/departure/$date?useTimeZone=true")
      .asStream()
      .map((e) => e.data)
      .map((e) => e["features"])
      .map((e) => (e as List).map((e) => e["properties"]).toList())
      .map((e) => e.map((e) => Train.fromJson(raw: e)).toList());
  }

  Stream<List<Destination>> getDestinations({required String name}) {
    return dio.get("$baseUrl/suggests/rstation/?namePart=$name&lang=ru")
      .asStream()
      .map((e) => e.data)
      .map((e) => e["data"])
      .map((e) => (e as List).map((e) => e["node"]).toList())
      .map((e) => e.map((e) => Destination.fromJson(raw: e)).toList());
  }

  Stream<List<ScheduleResponse>> getTrains({required ScheduleRequest request}) {
    return dio.post("$baseUrl/tt/train/schedule", data: request.toJson())
      .asStream()
      .map((e) => e.data)
      .map((e) => e["trains"])
      .map((e) => (e as List).map((e) => e).toList())
      .map((e) => e.map((e) => ScheduleResponse.fromJson(raw: e)).toList());
  }
}