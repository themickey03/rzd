import 'package:flutter/cupertino.dart';

mixin ExternalBuilder<T extends StatefulWidget> on State<T>{
  ExternalWidget get view;

  @override
  Widget build(BuildContext context) {
    ExternalWidget _view = view;
    _view._state = this;
    return _view.build(context);
  }

}

abstract class ExternalWidget<T> {
  late T _state;
  T get state => _state;

  WidgetBuilder get build;
}