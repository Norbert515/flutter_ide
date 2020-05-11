import 'package:widget_maker_2_0/material.dart';


mixin ValueChanger<T> {
  T get value;
  ValueChanged<T> get onUpdate;
}

abstract class StatelessValueChanger<T> extends StatelessWidget with ValueChanger<T> {
  final T value;
  final ValueChanged<T> onUpdate;
  /// Indicates whether this value can be nullable
  final bool nullable;

  @mustCallSuper
  StatelessValueChanger({Key key, @required this.value, @required this.onUpdate, @required this.nullable}) : super(key: key);
}

abstract class StatefulValueChanger<T> extends StatefulWidget with ValueChanger<T> {
  final T value;
  final ValueChanged<T> onUpdate;

  /// Indicates whether this value can be nullable
  final bool nullable;

  @mustCallSuper
  StatefulValueChanger({Key key, @required this.value, @required this.onUpdate, @required this.nullable}) : super(key: key);
}