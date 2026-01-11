import 'package:custom_accordion/custom_accordion.dart';
import 'package:flutter/cupertino.dart';
import 'package:rzd/dto/train.dart';
import 'package:rzd/item/item.dart';
import 'package:rzd/service/rzd_service.dart';
import 'package:collection/collection.dart';

class StationPage extends StatefulWidget {
  const StationPage({super.key});

  @override
  State<StationPage> createState() => _PageState();
}

class _PageState extends State<StationPage> {

  List<Train> dataPast = [];
  List<Train> dataNow = [];

  RzdService service = RzdService();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    getData();
  }

  Future<void> getData() {
    return service.getTrainData(
      station: "128EJ",
      date: "2026-01-08"
    ).listen((e) {
      Map<String, List<Train>> list = e.groupListsBy((station) => station.traversed == true ? "past" : "now");
      dataPast = list["past"] ?? [];
      dataNow = list["now"] ?? [];

      if (dataPast.length != 0) {
        dataNow.insert(0, dataPast.last);
        dataPast.removeLast();
      }

      if (mounted) {
        setState(() {});
      }
    }).asFuture();
  }

  @override
  Widget build(BuildContext context) {

    if (dataPast.isEmpty && dataNow.isEmpty) {
      return Center(child: SizedBox(height: 40, width: 40, child: CupertinoActivityIndicator()));
    }

    return CustomScrollView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: [
        CupertinoSliverNavigationBar(
          largeTitle: Container(),
        ),
        CupertinoSliverRefreshControl(onRefresh: getData),
        SliverList.list(
          children: [

            CustomAccordion(
              title: "История",
              widgetItems: Column(children: dataPast.map((e) => Item(train: e)).toList()),
            ),
            CustomAccordion(
              title: "В пути",
              showContent: true,
              backgroundColor: CupertinoColors.white.withAlpha(100),
              widgetItems: Column(children: dataNow.map((e) => Item(train: e)).toList()),
            ),
          ]
        )
      ],
    );
  }
}
