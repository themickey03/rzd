import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rzd/core/dto/destination.dart';
import 'package:rzd/core/dto/schedule/request.dart';
import 'package:rzd/core/dto/schedule/response.dart';
import 'package:rzd/core/extension/external_builder.dart';
import 'package:rzd/core/service/rzd_service.dart';
import 'package:rzd/pages/home/home_view.dart';
import 'package:searchfield/searchfield.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> with ExternalBuilder {

  @override
  ExternalWidget get view => HomeView();

  late RzdService rzdService;

  SearchFieldListItem<Destination>? departureTown;
  SearchFieldListItem<Destination>? arrivalTown;

  List<SearchFieldListItem<Destination>> suggestions = [];
  DateTime dateOfArrival = DateTime.now();

  List<ScheduleResponse> response = [];

  @override
  void initState() {
    super.initState();
    rzdService = context.read<RzdService>();
  }

  onDetartureTownTap(SearchFieldListItem<Destination> item) {
    print("!!! HERE: $item");
    setState(() {
      departureTown = item;
    });
  }

  onArrivalTownTap(SearchFieldListItem<Destination> item) {
    print("!!! HERE: $item");
    setState(() {
      arrivalTown = item;
    });
  }

  FutureOr<List<SearchFieldListItem<Destination>>>? search(String searchText) async {
    if (searchText.isEmpty || searchText.length < 3) {
      return [];
    }

    List<Destination> result = await rzdService.getDestinations(name: searchText).first;
    List<SearchFieldListItem<Destination>> mapped = result
      .map((e) => SearchFieldListItem<Destination>("${e.name}, ${e.region}", value: "${e.name}, ${e.region}", item: e))
      .toList();
    suggestions.addAll(mapped);
    return mapped;
  }

  void getData() {
    print(departureTown?.item);
    print(arrivalTown?.item);
    if  (departureTown?.item?.id == null || arrivalTown?.item?.id == null) {
      return;
    }
    rzdService.getTrains(request: ScheduleRequest(
      date: "12.01.2026",
      departureId: departureTown!.item!.id, 
      arrivalId: arrivalTown!.item!.id
    )).listen((e) {
      setState(() {
        response = e;
      });
    });
  }
}
