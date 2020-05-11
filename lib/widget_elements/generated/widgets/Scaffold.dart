import 'package:widget_maker_2_0/properties/basic_properties.dart';
import 'package:widget_maker_2_0/properties/icon_property.dart';
import 'package:widget_maker_2_0/widget_elements/base/widget_element.dart';
import 'package:widget_maker_2_0/widget_elements/widgets/base.dart';
import 'package:widget_maker_2_0/widget_elements/generated/properties/enums.dart';
import 'package:widget_maker_2_0/properties/decoration_property.dart';
import 'package:flutter/cupertino.dart';
import 'package:widget_maker_2_0/widget_elements/generated/properties/objects.dart';
import 'package:widget_maker_2_0/properties/wrappers/wrappers.dart';
import 'package:widget_maker_2_0/properties/enum_properties.dart';
import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/widget_elements/wrappers/wrappers.dart';
import 'package:widget_maker_2_0/widget_elements/widgets/scaffold.dart';

class ScaffoldElement extends WidgetElement with SlotChildElementMixin {
  ScaffoldElement({
    @required String id,
    Color backgroundColor,
  }) :
    backgroundColor = MColorProperty(
        value: backgroundColor?? null,
        name: "backgroundColor",
        defaultValue: null
    ),


      super(id);

    final MColorProperty backgroundColor;

    static const String BODY = "body";
  static const String APPBAR = "appBar";
  static const String FLOATINGACTIONBUTTON = "floatingActionButton";

  @override
  List<ChildSlot> constructChildSlots() => [
   SingleChildSlot(slotName: BODY),
   SingleChildSlot(slotName: APPBAR),
   SingleChildSlot(slotName: FLOATINGACTIONBUTTON),
  ];  
  
  @override
  List<MProperty> get attributes => [
    backgroundColor,
  ];

  @override
  Widget generateWidget() {
    return ScaffoldElementWidget(
      id: id,
    );
  }

  factory ScaffoldElement.fromMap(Map<String, dynamic> map) {
    return ScaffoldElement(
        id: map["id"],
        backgroundColor: map["backgroundColor"],
    );
  }

  @override
  String get name => "Scaffold";

}


// Can be found in the widgets folder