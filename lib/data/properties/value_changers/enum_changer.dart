import 'package:widget_maker_2_0/data/properties/value_changers/base.dart';
import 'package:widget_maker_2_0/data/properties/value_changers/widgets/common.dart';
import 'package:flutter/material.dart';


class EnumChanger<T> extends StatelessValueChanger<T>{

  final List<T> possibleValues;
  final String enumName;

  EnumChanger({Key key, T value, this.possibleValues, ValueChanged<T> onUpdate, bool nullable = true}):
      enumName = possibleValues[0].toString().split(".")[0],
        super(key: key, value: value, onUpdate: onUpdate, nullable: nullable);

  String _removePrefix(String name) {
    if(name == "null") return null;
    return name.split(".")[1];
  }

  // To make this nullable
  List<T> get _internalPossibleValues => nullable? (List.from(possibleValues)..add(null)): possibleValues;

  @override
  Widget build(BuildContext context) {
    return OutlineDropDownButton<String>(
      value: _removePrefix(value.toString()),
      items: _internalPossibleValues.map((it) => it.toString()).map(_removePrefix).map((string) {
        return DropdownMenuItem<String>(
          child: Text(string?? "",),
          value: string,
        );
      }).toList(),
      onChanged: (string) {
        if(string == null) {
          onUpdate(null);
        }
        onUpdate(possibleValues.firstWhere((it) => _removePrefix(it.toString() )== string));
      },
    );
  }
}

