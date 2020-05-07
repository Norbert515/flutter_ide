import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/data/properties/basic_properties.dart';

import 'nullable_changer.dart';

class ObjectChanger<T> extends StatefulWidget {

  final List<MProperty> properties;
  final String id;
  final String name;
  final ObjectConstructor<T> emptyConstructor;
  final T value;

  /// Always called with either null, or the empty constructor
  ///
  /// Other values are implicitly derived from the children properties
  final ValueChanged<T> onChange;

  const ObjectChanger({Key key, this.properties, this.id, this.name, this.emptyConstructor, this.onChange, this.value}) : super(key: key);

  @override
  _ObjectChangerState<T> createState() => _ObjectChangerState<T>();
}

class _ObjectChangerState<T> extends State<ObjectChanger> {


  List<Widget> getChangers(BuildContext context, String id) =>
      widget.properties.map((it) => it.getChanger(context, id)).toList();

  @override
  Widget build(BuildContext context) {
    return AddableProperty<T>(
      sameLine: false,
      value: widget.value,
      propertyName: widget.name,
      emptyConstructor: widget.emptyConstructor,
      onChange: widget.onChange,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: getChangers(context, widget.id)
      ),
    );
  }
}
