

import 'package:code_builder/code_builder.dart';
import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/data/properties/basic_properties.dart';
import 'package:widget_maker_2_0/data/properties/value_changers/widgets/multi_changer.dart';
import 'package:widget_maker_2_0/data/properties/value_changers/widgets/object_changer.dart';
import 'package:widget_maker_2_0/data/string_builder.dart';
import 'package:widget_maker_2_0/data/widget_elements/generated/properties/enums.dart';

import 'enum_properties.dart';

enum _DecorationType {
  BoxDecoration,
  FlutterLogoDecoration,
  ShapeDecoration,
  Unknown,
  none,
}

class MDecorationProperty extends MProperty<Decoration> {

  MDecorationProperty({
    String name,
    Decoration value,
    bool isNamed= true,
    bool isRequired = false,
    bool nullable = true,
    Decoration defaultValue,
  }): super(
      name: name,
      value: value,
      isNamed: isNamed,
      isRequired: isRequired,
      nullable: nullable,
      defaultValue: defaultValue,
  );

  @override
  MDecorationProperty copy() {
    return MDecorationProperty(
      name: name,
      value: value,
      isNamed: isNamed,
      isRequired: isRequired,
      nullable: nullable,
    );
  }

  final MBoxDecorationProperty _mBoxDecorationProperty = MBoxDecorationProperty();

  _DecorationType _selected = _DecorationType.none;

  List<String> names = ["Box", "FlutterLogo", "Shape", "Unkown", "None"];


  void onChange(it, stateSetter) {
    stateSetter(() {
      _selected = it;
    });
  }

  @override
  Widget buildFinalChanger(BuildContext context, String id) {
    return StatefulBuilder(
      builder: (context, stateSetter) {
        return MultiChanger(
          name: name,
          selectedOption: _selected,
          options: _DecorationType.values,
          names: names,
          changer: getDecorationChanger(context, id),
          onChange: (it) => onChange(it, stateSetter),
         /* value: value,
          onChange: (it) {
            updateValue(it, context, id);
          },*/
        );
      }
    );
  }

  Widget getDecorationChanger(BuildContext context, String id) {
    if(_selected == _DecorationType.BoxDecoration) {
      return _mBoxDecorationProperty.buildChanger(context, id);
    }

    return Text("Not Box");
  }
  @override
  Expression toCode() {
    // TODO: implement toCode
  }

}


class MBoxDecorationProperty extends MProperty<BoxDecoration> with SingleChangerMixin<BoxDecoration>{
  
  
  final MColorProperty color;
  final MDecorationImageProperty image;
  final MBorderProperty border;
  final MBorderRadiusGeometryProperty borderRadius;
  final MGradientProperty gradient;

  MBoxDecorationProperty():
    color = MColorProperty(
      name: "color",
      value: null
    ),
    image = MDecorationImageProperty(),
    border = MBorderProperty(),
    borderRadius = MBorderRadiusGeometryProperty(),
    gradient = MGradientProperty();


  MBoxDecorationProperty copy() {
    return MBoxDecorationProperty();
  }

  List<MProperty> get properties => [/*image, */border,/* borderRadius, gradient*/];

  @override
  Widget buildChanger(BuildContext context, String id) {
    return ObjectChanger(
      emptyConstructor: () => const BoxDecoration(),
      properties: properties,
      name: "Box Decoration",
      value: value,
      onChange: (it) => updateValue(it, context, id),
      id: id,

    );
  }

  @override
  Expression toCode() {
    // TODO: implement toCode
    return null;
  }

}

class MShapeDecorationProperty extends MProperty<ShapeDecoration> with SingleChangerMixin<ShapeDecoration> {
  @override
  Widget buildChanger(BuildContext context, String id) {
    // TODO: implement buildChanger
    return null;
  }

  @override
  Expression toCode() {
    // TODO: implement toCode
    return null;
  }

  @override
  MProperty<ShapeDecoration> copy() {
    // TODO: implement copy
    return null;
  }
  
}

class MDecorationImageProperty extends MProperty<DecorationImage> with SingleChangerMixin<DecorationImage> {


  @override
  Widget buildChanger(BuildContext context, String id) {
    // TODO: implement buildChanger
    return null;
  }

  @override
  Expression toCode() {
    // TODO: implement toCode
    return null;
  }

  @override
  MProperty<DecorationImage> copy() {
    // TODO: implement copy
    return null;
  }

}

class MBorderProperty extends MProperty<Border> with SingleChangerMixin<Border> {

  final MBorderSideProperty top;
  final MBorderSideProperty right;
  final MBorderSideProperty bottom;
  final MBorderSideProperty left;

  MBorderProperty():
      top = MBorderSideProperty(),
      right = MBorderSideProperty(),
      bottom = MBorderSideProperty(),
      left = MBorderSideProperty();


  @override
  Widget buildChanger(BuildContext context, String id) {
    return ObjectChanger(
      properties: [top, right, bottom, left],
      id: id,
      value: value,
      emptyConstructor: () => Border(),
      name: "Border",
      onChange: (it) => updateValue(it, context ,id),
    );
  }

  @override
  Expression toCode() {
    // TODO: implement toCode
    return null;
  }

  @override
  MProperty<Border> copy() {
    // TODO: implement copy
    return null;
  }

}

class MBorderSideProperty extends MProperty<BorderSide> with SingleChangerMixin<BorderSide> {


  final MColorProperty color;
  final MDoubleProperty width;
  final MBorderStyleProperty style;

  MBorderSideProperty():
      color = MColorProperty(),
      width = MDoubleProperty(),
      style = MBorderStyleProperty();

  @override
  Widget buildChanger(BuildContext context, String id) {
    return ObjectChanger(
      name: "Border Side",
      emptyConstructor: () => BorderSide(),
      value: value,
      properties: [color, width, style],
      onChange: (it) => updateValue(it, context, id),
      id: id,
    );
  }

  @override
  Expression toCode() {
    // TODO: implement toCode
    return null;
  }

  @override
  MProperty<BorderSide> copy() {
    // TODO: implement copy
    return null;
  }

}

class MBorderRadiusGeometryProperty extends MProperty<BorderRadiusGeometry> with SingleChangerMixin<BorderRadiusGeometry> {
  @override
  Widget buildChanger(BuildContext context, String id) {
    // TODO: implement buildChanger
    return null;
  }

  @override
  Expression toCode() {
    // TODO: implement toCode
    return null;
  }

  @override
  MProperty<BorderRadiusGeometry> copy() {
    // TODO: implement copy
    return null;
  }

}

class MGradientProperty extends MProperty<Gradient> with SingleChangerMixin<Gradient> {
  @override
  Widget buildChanger(BuildContext context, String id) {
    // TODO: implement buildChanger
    return null;
  }

  @override
  Expression toCode() {
    // TODO: implement toCode
    return null;
  }

  @override
  MProperty<Gradient> copy() {
    // TODO: implement copy
    return null;
  }

}