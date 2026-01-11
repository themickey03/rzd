import 'package:flutter/cupertino.dart';
import 'package:rzd/page/test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
        barBackgroundColor: CupertinoColors.inactiveGray,
        scaffoldBackgroundColor: CupertinoColors.white
      ),
      title: 'Поезд 128E',
      home: TestPage(),
    );
  }
}
