import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rzd/core/dto/schedule/request_history.dart';
import 'package:rzd/core/extension/external_builder.dart';
import 'package:rzd/core/service/history_service.dart';
import 'package:rzd/pages/history/history_view.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> with ExternalBuilder {

  @override
  ExternalWidget get view => HistoryView();

  late HistoryService historyService;

  List<ScheduleRequestHistory> historyRequests = [];

  @override
  void initState() {
    super.initState();
    historyService = context.read<HistoryService>();
    loadData();
  }

  void loadData() {
    setState(() {
      historyRequests = historyService.getHistory();
    });
  }

  void clearHistory() {
    historyService.clearHistory();
    if (mounted) {
      setState(() {});
    }
  }

  void removeItem(ScheduleRequestHistory request) {
    historyService.removeFromHistory(request: request);
    loadData();
  }
}
