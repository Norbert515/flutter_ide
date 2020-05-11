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
import 'package:widget_maker_2_0/widget_elements/widgets/listtile.dart';

class ListTileElement extends WidgetElement with SlotChildElementMixin {
  ListTileElement({
    @required String id,
    bool isThreeLine,
    bool dense,
    EdgeInsets contentPadding,
    bool enabled,
  }) :
    isThreeLine = MBoolProperty(
        value: isThreeLine?? false,
        name: "isThreeLine",
        defaultValue: false
    ),

    dense = MBoolProperty(
        value: dense?? null,
        name: "dense",
        defaultValue: null
    ),

    contentPadding = MEdgeInsetsProperty(
        value: contentPadding?? null,
        name: "contentPadding",
        defaultValue: null
    ),

    enabled = MBoolProperty(
        value: enabled?? true,
        name: "enabled",
        defaultValue: true
    ),


      super(id);

    final MBoolProperty isThreeLine;
    final MBoolProperty dense;
    final MEdgeInsetsProperty contentPadding;
    final MBoolProperty enabled;

    static const String LEADING = "leading";
  static const String TITLE = "title";
  static const String SUBTITLE = "subtitle";
  static const String TRAILING = "trailing";

  @override
  List<ChildSlot> constructChildSlots() => [
   SingleChildSlot(slotName: LEADING),
   SingleChildSlot(slotName: TITLE),
   SingleChildSlot(slotName: SUBTITLE),
   SingleChildSlot(slotName: TRAILING),
  ];  
  
  @override
  List<MProperty> get attributes => [
    isThreeLine,
    dense,
    contentPadding,
    enabled,
  ];

  @override
  Widget generateWidget() {
    return ListTileElementWidget(
      id: id,
    );
  }

  factory ListTileElement.fromMap(Map<String, dynamic> map) {
    return ListTileElement(
        id: map["id"],
        isThreeLine: map["isThreeLine"],
        dense: map["dense"],
        contentPadding: map["contentPadding"],
        enabled: map["enabled"],
    );
  }

  @override
  String get name => "ListTile";

}


// Can be found in the widgets folder