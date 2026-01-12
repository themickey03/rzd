import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';
import 'package:rzd/core/dto/destination.dart';
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
              SizedBox(height: 4),
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