import 'package:flutter/material.dart';
import 'package:rzd/dto/train.dart';

class Item extends StatefulWidget {
  final Train train;

  const Item({required this.train, super.key});

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    int? arrivalDelay = widget.train.arrivalDelayMinutes;
    int? departureDelay = widget.train.departureDelayMinutes;

    bool arrivalShow = arrivalDelay != null && arrivalDelay != 0;
    bool departureShow = departureDelay != null && departureDelay != 0;

    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(10),
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
            Divider(),
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
              Divider(),
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
    );
  }

  Widget buildText({required String date, required String time, required bool departure}) {
    return Column(
      children: [
        Text(
          !departure ? "Прибытие" : "Отправление",
          style: TextStyle(color: Colors.black.withAlpha(100)),
        ),
        Text(date),
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
        style: TextStyle(color: Colors.green.shade300),
      );
    }

    return Text(
      "Задежка ${departure ? "отправления" : "прибытия"}: ${minute?.abs() ?? ""} мин.",
      style: TextStyle(color: Colors.red.shade300),
    );
  }
}
