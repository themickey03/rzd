import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rzd/core/dto/train.dart';
import 'package:rzd/core/extension/external_builder.dart';
import 'package:rzd/pages/train_details/train_details_view.dart';
import 'package:rzd/core/service/rzd_service.dart';
import 'package:collection/collection.dart';

class TrainDetailsPage extends StatefulWidget {

  final String? trainNumber;
  final String? trainDate;

  const TrainDetailsPage({
    this.trainNumber,
    this.trainDate,
    super.key
  });

  @override
  State<TrainDetailsPage> createState() => TrainDetailsPageState();
}

class TrainDetailsPageState extends State<TrainDetailsPage> with ExternalBuilder {

  @override
  ExternalWidget get view => TrainDetailsView();

  late RzdService service;

  List<Train> dataPast = [];
  List<Train> dataNow = [];

  bool get showEmptyPage => widget.trainNumber == null || widget.trainDate == null;

  CupertinoTabController controller = CupertinoTabController(initialIndex: 1);

  @override
  void initState() {
    super.initState();
    service = context.read<RzdService>();

    getData();
  }

  Future<void> getData() {

    if (showEmptyPage) {
      return Future.value();
    }

    return service.getTrainData(
      station: widget.trainNumber!,
      date: widget.trainDate!
    ).listen(setData).asFuture();
  }

  void setData(List<Train> trains) {
    Map<String, List<Train>> list = trains.groupListsBy((station) => station.traversed == true ? "past" : "now");
    dataPast = list["past"] ?? [];
    dataNow = list["now"] ?? [];

    if (dataPast.isNotEmpty) {
      dataNow.insert(0, dataPast.last);
      dataPast.removeLast();
    }

    if (mounted) {
      setState(() {});
    }
  }
}
