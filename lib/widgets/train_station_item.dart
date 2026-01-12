import 'package:flutter/cupertino.dart';
import 'package:rzd/core/dto/train.dart';

class TrainStationItem extends StatefulWidget {
  final Train train;

  const TrainStationItem({required this.train, super.key});

  @override
  State<TrainStationItem> createState() => _TrainStationItemState();
}

class _TrainStationItemState extends State<TrainStationItem> {
  @override
  Widget build(BuildContext context) {
    int? arrivalDelay = widget.train.arrivalDelayMinutes;
    int? departureDelay = widget.train.departureDelayMinutes;

    bool arrivalShow = arrivalDelay != null && arrivalDelay != 0;
    bool departureShow = departureDelay != null && departureDelay != 0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: ClipRRect(
        borderRadius: .circular(15),
        child: ColoredBox(
          color: CupertinoColors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.train.name ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: widget.train.withoutStop != true ? 20 : 16
                  )
                ),
                Container(
                  height: 2,
                  color: CupertinoColors.white,
                ),
                if (widget.train.withoutStop == true) ...[
                  if (widget.train.arrivalDate != null && widget.train.arrivalTime != null) ...[
                    Text("Станция без остановки"),
                    Text("Время проезда: ${widget.train.arrivalDate} ${widget.train.arrivalTime}")
                  ],
                ] else ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.train.arrivalDate != null && widget.train.arrivalTime != null) ...[
                        Expanded(child: buildText(
                          date: widget.train.arrivalDate!,
                          time: widget.train.arrivalTime!,
                          departure: false
                        ))
                      ],
                      if (widget.train.departureDate != null && widget.train.departureTime != null) ...[
                        Expanded(child: buildText(
                          date: widget.train.departureDate!,
                          time: widget.train.departureTime!,
                          departure: true
                        ))
                      ],
                    ],
                  )
                ],
                if (arrivalShow || departureShow) ...[
                  Container(
                    height: 2,
                    color: CupertinoColors.white,
                  ),
                ],
                if (arrivalShow) ...[
                  convertNegativeToWord(minute: arrivalDelay, departure: false)
                ],
                if (departureShow) ...[
                  convertNegativeToWord(minute: departureDelay, departure: true)
                ]
            
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildText({required String date, required String time, required bool departure}) {
    return Column(
      children: [
        Text(
          !departure ? "Прибытие" : "Отправление",
          style: TextStyle(fontSize: 14, color: CupertinoColors.inactiveGray),
        ),
        Text(
          date,
          style: TextStyle(fontSize: 14, color: CupertinoColors.inactiveGray),
        ),
        Text(
          time,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
      ],
    );
  }

  Widget convertNegativeToWord({int? minute, required bool departure}) {
    if (minute?.isNegative == true) {
      return Text(
        "Опережение ${departure ? "отправления" : "прибытия"}: ${minute?.abs() ?? ""} мин.",
        style: TextStyle(color: CupertinoColors.systemGreen.withAlpha(100)),
      );
    }

    return Text(
      "Задержка ${departure ? "отправления" : "прибытия"}: ${minute?.abs() ?? ""} мин.",
      style: TextStyle(color: CupertinoColors.systemRed.withAlpha(100)),
    );
  }
}
