import 'package:flutter/cupertino.dart';

mixin ExternalBuilder<T extends StatefulWidget> on State<T>{
  ExternalWidget get view;

  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    print("!!!! 1, $view");
    view.state = this;
    print("!!!! 2, ${view.state}");
    return view.build(context);
  }

}

abstract class ExternalWidget<T> {
  late T state;

  WidgetBuilder get build;
}