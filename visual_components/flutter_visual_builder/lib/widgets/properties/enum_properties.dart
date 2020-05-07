import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/utils/string_builder.dart';
import 'package:flutter_visual_builder/widgets/properties/property.dart';

abstract class EnumProperty<T> extends Property<T> {

  EnumProperty(T data, dynamic values) : values = values, super(data);
  EnumProperty.fromMap(Map map, dynamic values): values = values,
        super(values.firstWhere((it) => it.toString() == map['value']));

  List<String> get stringValues => List<String>.from(values.map((it) => it.toString()));

  EnumProperty copyWith(String value);

  /// This is a list of enums
  final dynamic values;

  @override
  Map getMapData() => {
    'value': data.toString(),
  };


  @override
  void fillSourceCode(StringBuilder builder) {
    builder.write(data.toString());
  }

}

class CrossAxisAlignmentProperty extends EnumProperty<CrossAxisAlignment> {
  CrossAxisAlignmentProperty(CrossAxisAlignment data) : super(data, CrossAxisAlignment.values);
  CrossAxisAlignmentProperty.fromMap(Map map) : super.fromMap(map, CrossAxisAlignment.values);

  EnumProperty copyWith(String value) {
    return CrossAxisAlignmentProperty.fromMap({'value': value});
  }

  @override
  PropertyType get type => PropertyType.crossAxisAlignment;


}

class MainAxisAlignmentProperty extends EnumProperty<MainAxisAlignment> {
  MainAxisAlignmentProperty(MainAxisAlignment data) : super(data, MainAxisAlignment.values);
  MainAxisAlignmentProperty.fromMap(Map map) : super.fromMap(map, MainAxisAlignment.values);

  EnumProperty copyWith(String value) {
    return MainAxisAlignmentProperty.fromMap({'value': value});
  }

  @override
  PropertyType get type => PropertyType.mainAxisAlignment;

}