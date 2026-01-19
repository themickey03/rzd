import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rzd/core/utils/utils.dart';
import 'package:localization/localization.dart';
import 'package:rzd/core/dto/schedule/request_history.dart';
import 'package:rzd/core/extension/external_builder.dart';
import 'package:rzd/pages/history/history_page.dart';

class HistoryView extends ExternalWidget {
  @override
  WidgetBuilder get build => _View(state).build;
}

extension _View on HistoryPageState {
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        trailing: Material(
          child: InkWell(
            onTap: clearHistory,
            child: Icon(
              CupertinoIcons.trash,
              color: CupertinoColors.darkBackgroundGray,
              size: 20
            ),
          ),
        )
      ),
      child: Material(child: ListView(shrinkWrap: true, children: historyRequests.map((e) => buildDataRaw(e)).toList()))
    );
  }

  Widget buildDataRaw(ScheduleRequestHistory request) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              // context.pop({"history": request});
              // context.pushReplacement("/", extra: {"history": request});
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text("${"date".i18n()}: ${request.date}"),
                  Text("${"arrivalName".i18n()}: ${request.arrivalName.toString()}"),
                  Text("${"departureName".i18n()}: ${request.departureName.toString()}"),
                  Text("${"departure_bool".i18n()}: ${"departure_${request.departure}".i18n()}"),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 30,
          child: InkWell(
            onTap: () => removeItem(request),
            child: Icon(CupertinoIcons.delete)
          )
        ),
        SizedBox(width: 16)
      ],
    );
  }
}