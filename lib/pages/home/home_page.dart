import 'package:flutter/cupertino.dart';
import 'package:rzd/core/extension/external_builder.dart';
import 'package:rzd/pages/home/home_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> with ExternalBuilder {

  @override
  ExternalWidget get view => HomeView();

}
