import 'package:code_builder/code_builder.dart';
import 'package:widget_maker_2_0/data/properties/value_changers/enum_changer.dart';
import 'package:widget_maker_2_0/data/string_builder.dart';
import 'package:flutter/material.dart';
import 'basic_properties.dart';

abstract class MEnumProperty<T> extends MProperty<T> with SingleChangerMixin{

  MEnumProperty({
    @required T value,
    @required this.possibleValues,
    @required String name,
    @required isNamed,
    @required isRequired,
    @required T defaultValue,
}): super(value: value, name: name, isNamed: isNamed, isRequired: isRequired, defaultValue: defaultValue);


  final List<T> possibleValues;

  @override
  Expression toCode() => convertToCode<T>(value);

  static Expression convertToCode<T>(T value) {
    if(value == null) return literalNull;
    var str = value.toString();
    var parts = str.split(".");
    assert(parts.length == 2);
    return refer(parts[0]).property(parts[1]);

  }

  @override
  Widget buildChanger(BuildContext context, String id) {
    return EnumChanger<T>(
      value: value,
      possibleValues: possibleValues,
      onUpdate: (T newValue) {
        updateValue(newValue, context, id);
      },
    );
  }

}

