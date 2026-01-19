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

    Widget child;
    if (showEmptyPage) {
      child = Column(
        crossAxisAlignment: .center,
        children: [
          SizedBox(height: 4),
          Center(child: Text("Ошибка", style: TextStyle(fontSize: 20, color: CupertinoColors.destructiveRed))),
          Center(child: Text("Не указаны номер поезда или дата поездки"))
        ],
      );
    } else if (dataPast.isEmpty && dataNow.isEmpty) {
      child = Center(child: SizedBox(height: 40, width: 40, child: CupertinoActivityIndicator(color: CupertinoColors.black)));
    } else {
      child = CupertinoTabScaffold(
        controller: controller,
        backgroundColor: CupertinoColors.lightBackgroundGray,
        tabBar: CupertinoTabBar(
          onTap: (i) => controller,
          items: [
            BottomNavigationBarItem(
              key: Key("history"),
              icon: Icon(CupertinoIcons.gobackward),
              label: "История"
            ),
            BottomNavigationBarItem(
              key: Key("live"),
              icon: Icon(CupertinoIcons.play_fill),
              label: "В пути"
            ),
          ]
        ),
        tabBuilder: (ctx, i) {
          List list = (i == 0 ? dataPast : dataNow);
          if (list.length == 0) {
            return Center(
              child: Column(
                crossAxisAlignment: .center,
                children: [
                  SizedBox(height: 4),
                  Text("Нет данных")
                ],
              ),
            );
          }
          return ListView(children: list.map((e) => TrainStationItem(train: e)).toList());
        }
      );
    }

    return CupertinoPageScaffold(navigationBar: CupertinoNavigationBar(), child: child);
  }
}