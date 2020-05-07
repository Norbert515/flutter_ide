import 'package:code_builder/code_builder.dart';
import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/data/code_builder.dart';
import 'package:widget_maker_2_0/data/properties/wrappers/wrappers.dart';
import 'basic_properties.dart';

class MOffsetProperty extends MObjectProperty<Offset> {

  MOffsetProperty({ Offset value, String name, Offset defaultValue}):
        props = {
          "dx": MDoubleProperty(
            name: "dx",
            value: value?.dx,
            allowNegative: true,
            defaultValue: const Offset(0,0).dx,
          ),
          "dy": MDoubleProperty(
            name: "dy",
            value: value?.dy,
            allowNegative: true,
            defaultValue: const Offset(0,0).dy,
          ),
        }, super(name: "Offset", value: value, defaultValue: defaultValue);

  final Map<String, MProperty> props;

  @override
  MOffsetProperty copy() {
    return MOffsetProperty(
      value: value,
      name: name,
    );
  }

  @override
  List<MProperty> getProperties() {
    return props.values.toList();
  }
  @override
  Offset get value => internalValue == null? null: WOffset(
    dx: props["dx"].value,
    dy: props["dy"].value,
  );

  Map<String, dynamic> toMap() {
    return {
      "dx": props["dx"].value.serialize(),
      "dy": props["dy"].value.serialize(),
    };
  }

  @override
  Expression toCode() {
    return propertyConstructor("Offset", props.values);
  }
  @override
  Offset constructEmpty() => WOffset();

}
