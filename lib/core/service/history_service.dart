import 'dart:convert';

import 'package:rzd/core/dto/schedule/request_history.dart';
import 'package:rzd/core/service/storage_service.dart';

class HistoryService {

  late StorageService _storageService;

  HistoryService({required StorageService storageService}) {
    _storageService = storageService;
  }

  final String _historyKey = "rzd_history";

  List<ScheduleRequestHistory> getHistory() {
    if (_storageService[_historyKey] != null) {
      return _getData(jsonDecode(_storageService[_historyKey]));
    }

    return [];
  }

  void addToHistory({required ScheduleRequestHistory request}) {
    List<ScheduleRequestHistory> data = getHistory();
    if (data.contains(request)) {
      return;
    }
    data.add(request);
    _setData(data);
  }

  void saveHistory({required List<ScheduleRequestHistory> data}) {
    _setData(data);
  }

  void removeFromHistory({required ScheduleRequestHistory request}) {
    List<ScheduleRequestHistory> data = getHistory();
    if (!data.contains(request)) {
      return;
    }
    data.remove(request);
    _setData(data);
  }

  void clearHistory() {
    _storageService[_historyKey] = null;
  }

  List<ScheduleRequestHistory> _getData(dynamic raw) {
    if (raw is List) {
      return (raw).map((e) => ScheduleRequestHistory.fromJson(e)).toList();
    }

    if (raw is Map) {
      return [ScheduleRequestHistory.fromJson(raw.cast<String, dynamic>())];
    }

    return [];
  }

  void _setData(List<ScheduleRequestHistory> data) {
    _storageService[_historyKey] = jsonEncode(data.map((e) {
      return e.toJson();
    }).toList());
  }
}