

import 'package:flutter/material.dart';

typedef ValueChangerFactory<T> = ValueChanger Function(dynamic value, dynamic onChanged);

class ValueChangerRegistry {

  static Map<Type, ValueChangerFactory> map;
}

mixin ValueChanger<T> on Widget{
  ValueChanged<T> get onChange;
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
