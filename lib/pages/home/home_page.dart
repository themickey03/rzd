import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rzd/core/dto/destination.dart';
import 'package:rzd/core/dto/schedule/request.dart';
import 'package:rzd/core/dto/schedule/request_history.dart';
import 'package:rzd/core/dto/schedule/response.dart';
import 'package:rzd/core/extension/external_builder.dart';
import 'package:rzd/core/service/history_service.dart';
import 'package:rzd/core/service/rzd_service.dart';
import 'package:rzd/core/utils/utils.dart';
import 'package:rzd/pages/home/home_view.dart';
import 'package:searchfield/searchfield.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> with ExternalBuilder, RouteAware {

  @override
  ExternalWidget get view => HomeView();

  late RzdService rzdService;
  late HistoryService historyService;

  SearchFieldListItem<Destination>? departureTown;
  SearchFieldListItem<Destination>? arrivalTown;

  List<SearchFieldListItem<Destination>> suggestions = [];
  DateTime dateOfArrival = DateTime.now();
  bool departure = true;

  List<ScheduleResponse> response = [];
  //
  // @override
  // void didPop() {
  //   super.didPop();
  // }
  //
  // @override
  // void didPush() {
  //   super.didPush();
  // }
  //
  // @override
  // void didPopNext() {
  //   super.didPopNext();
  // }
  //
  // @override
  // void didPushNext() {
  //   super.didPushNext();
  // }

  @override
  void initState() {
    super.initState();
    rzdService = context.read<RzdService>();
    historyService = context.read<HistoryService>();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   RouteObserver routeObserver = RouteObserver();
    //   routeObserver.subscribe(this, ModalRoute.of(context) as Route<dynamic>);
    // });
  }

  void setDataFromHistory() async {
    ScheduleRequestHistory? history = (GoRouterState.of(context).extra as Map?)!["history"];
    if (history == null) {
      return;
    }

    await Future.wait([
      search(history.departureName),
      search(history.arrivalName),
    ] as Iterable<Future<List<SearchFieldListItem<Destination>>>>).then((data) {
      departureTown = data[0].firstWhere((e) => e.item?.name == history.departureName);
      arrivalTown = data[1].firstWhere((e) => e.item?.name == history.arrivalName);
    });
    dateOfArrival = Utils.convertDateTextToDateTime(history.date);

    departure = history.departure;
    if (mounted) {
      setState(() {});
    }
  }

  onDepartureTownTap(SearchFieldListItem<Destination> item) {
    setState(() {
      departureTown = item;
    });
  }

  onArrivalTownTap(SearchFieldListItem<Destination> item) {
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
  
  void onDateChanged(DateTime date) {
    if (mounted) {
      setState(() {
        dateOfArrival = date;
      });
    }
  }

  void onDepartureChanged(bool? state) {
    if (mounted) {
      setState(() {
        departure = state == true;
      });
    }
  }

  void getData() {
    if (departureTown?.item?.id == null || arrivalTown?.item?.id == null) {
      return;
    }
    ScheduleRequest request = ScheduleRequest(
      departure: departure,
      date: Utils.formatDate(date: dateOfArrival) ?? "",
      departureId: departureTown!.item!.id,
      arrivalId: arrivalTown!.item!.id
    );
    rzdService.getTrains(request: request).listen((e) {
      setState(() {
        response = e;
        ScheduleRequestHistory f = ScheduleRequestHistory.fromJson({
          ...request.toJson(),
          "arrivalName":  arrivalTown!.item!.name,
          "departureName":  departureTown!.item!.name,
        });
        historyService.addToHistory(request: f);
      });
    });
  }
}
