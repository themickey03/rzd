import 'package:cupertino_calendar_picker/cupertino_calendar_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rzd/core/dto/destination.dart';
import 'package:rzd/core/dto/schedule/request.dart';
import 'package:rzd/core/extension/external_builder.dart';
import 'package:rzd/pages/home/home_page.dart';
import 'package:searchfield/searchfield.dart';

class HomeView extends ExternalWidget {
  @override
  WidgetBuilder get build => _View(state).build;
}

extension _View on HomePageState {
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(),
      child: Material(
        child: ListView(
          children: [
            SearchField<Destination>(
              key: Key("departureSearhField"),
              hint: 'Станция отправления',
              maxSuggestionBoxHeight: 300,
              onSuggestionTap: onDetartureTownTap,
              onSearchTextChanged: search,
              selectedValue: departureTown,
              suggestions: suggestions ?? [],
              suggestionState: Suggestion.expand,
            ),
            SizedBox(height: 20),
            SearchField<Destination>(
              key: Key("arrivalSearhField"),
              hint: 'Станция прибытия',
              maxSuggestionBoxHeight: 300,
              onSuggestionTap: onArrivalTownTap,
              onSearchTextChanged: search,
              selectedValue: arrivalTown,
              suggestions: suggestions ?? [],
              suggestionState: Suggestion.expand,
            ),
            const SizedBox(height: 20),
            CupertinoCalendarPickerButton(
              minimumDateTime: DateTime(1970, 1, 1),
              maximumDateTime: DateTime(2099, 1, 1),
              onDateSelected: onDateChanged,
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                GestureDetector(
                  onTap: () => onDepartureChanged(true),
                  child: Row(
                    children: [
                      RadioGroup(groupValue: departure, onChanged: onDepartureChanged, child: CupertinoRadio(value: true)),
                      Text("Отправление"),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () => onDepartureChanged(false),
                  child: Row(
                    children: [
                      RadioGroup(groupValue: departure, onChanged: onDepartureChanged, child: CupertinoRadio(value: false)),
                      Text("Прибытие"),
                    ],
                  ),
                )
              ],
            ),
            Divider(),
            CupertinoButton(
              onPressed: getData,
              child: Text("Запросить данные")
            ),
            if (response.length > 0) ...[
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: response.map((e) => GestureDetector(
                  onTap: () => context.go("/details?train=${e.numberLatin}&date=2026-01-12"),
                  child: Column(
                    children: [
                      Text(e.numberRus),
                      Text(e.arrivalStation.dateTime),
                      Text(e.departureStation.dateTime)
                    ],
                  ),
                )).toList(),
              )
            ]
          ],
        ),
      )
    );
  }
}