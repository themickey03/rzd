import 'package:custom_accordion/custom_accordion.dart';
import 'package:flutter/cupertino.dart';
import 'package:rzd/core/extension/external_builder.dart';
import 'package:rzd/pages/train_details/train_details_page.dart';
import 'package:rzd/widgets/train_station_item.dart';

class TrainDetailsView extends ExternalWidget {
  @override
  WidgetBuilder get build => _View(state).build;

}

extension _View on TrainDetailsPageState {
  Widget build(BuildContext context) {

    if (showEmptyPage) {
      return Text("Не указаны номер поезда или дата поездки");
    }

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
                widgetItems: Column(children: dataPast.map((e) => TrainStationItem(train: e)).toList()),
              ),
              CustomAccordion(
                title: "В пути",
                showContent: true,
                backgroundColor: CupertinoColors.white.withAlpha(100),
                widgetItems: Column(children: dataNow.map((e) => TrainStationItem(train: e)).toList()),
              ),
            ]
        )
      ],
    );
  }
}