import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:rzd/core/extension/external_builder.dart';
import 'package:rzd/pages/home/home_page.dart';

class HomeView extends ExternalWidget {
  @override
  WidgetBuilder get build => _View(state).build;
}

extension _View on HomePageState {
  Widget build(BuildContext context) {
    print("!!!!! 3");
    return Column(
      children: [
        Text("Test"),
        CupertinoButton(
          child: Text("Click"),
          onPressed: () => context.go("/details?train=128EJ&date=2026-01-08")
        )
      ],
    );
  }
}