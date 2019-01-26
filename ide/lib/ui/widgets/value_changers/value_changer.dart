

import 'package:flutter/material.dart';

mixin ValueChanger<T> on Widget{
  ValueChanged<T> get onUpdate;
  T get value;

}


class ValueWidget extends StatelessWidget {

  const ValueWidget({Key key, this.valueChanger, this.id}) : super(key: key);

  final ValueChanger valueChanger;
  final String id;

  @override
  Widget build(BuildContext context) {
    return valueChanger;
  }
}
