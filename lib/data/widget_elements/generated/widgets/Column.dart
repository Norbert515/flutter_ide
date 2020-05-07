import 'package:widget_maker_2_0/data/properties/basic_properties.dart';
import 'package:widget_maker_2_0/data/properties/icon_property.dart';
import 'package:widget_maker_2_0/data/widget_elements/base/widget_element.dart';
import 'package:widget_maker_2_0/data/widget_elements/widgets/base.dart';
import 'package:widget_maker_2_0/data/widget_elements/generated/properties/enums.dart';
import 'package:widget_maker_2_0/data/properties/decoration_property.dart';
import 'package:flutter/cupertino.dart';
import 'package:widget_maker_2_0/data/widget_elements/generated/properties/objects.dart';
import 'package:widget_maker_2_0/data/properties/wrappers/wrappers.dart';
import 'package:widget_maker_2_0/data/properties/enum_properties.dart';
import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/data/widget_elements/wrappers/wrappers.dart';
import 'package:widget_maker_2_0/data/widget_elements/widgets/column.dart';

class ColumnElement extends WidgetElement with SlotChildElementMixin {
  ColumnElement({
    @required String id,
    CrossAxisAlignment crossAxisAlignment,
    MainAxisSize mainAxisSize,
    MainAxisAlignment mainAxisAlignment,
  }) :
    crossAxisAlignment = MCrossAxisAlignmentProperty(
        value: crossAxisAlignment?? CrossAxisAlignment.center,
        name: "crossAxisAlignment",
        defaultValue: CrossAxisAlignment.center
    ),

    mainAxisSize = MMainAxisSizeProperty(
        value: mainAxisSize?? MainAxisSize.max,
        name: "mainAxisSize",
        defaultValue: MainAxisSize.max
    ),

    mainAxisAlignment = MMainAxisAlignmentProperty(
        value: mainAxisAlignment?? MainAxisAlignment.start,
        name: "mainAxisAlignment",
        defaultValue: MainAxisAlignment.start
    ),


      super(id);

    final MCrossAxisAlignmentProperty crossAxisAlignment;
    final MMainAxisSizeProperty mainAxisSize;
    final MMainAxisAlignmentProperty mainAxisAlignment;

    static const String CHILDREN = "children";

  @override
  List<ChildSlot> constructChildSlots() => [
   ListChildSlot(slotName: CHILDREN),
  ];  
  
  @override
  List<MProperty> get attributes => [
    crossAxisAlignment,
    mainAxisSize,
    mainAxisAlignment,
  ];

  @override
  Widget generateWidget() {
    return ColumnElementWidget(
      id: id,
    );
  }

  factory ColumnElement.fromMap(Map<String, dynamic> map) {
    return ColumnElement(
        id: map["id"],
        crossAxisAlignment: map["crossAxisAlignment"],
        mainAxisSize: map["mainAxisSize"],
        mainAxisAlignment: map["mainAxisAlignment"],
    );
  }

  @override
  String get name => "Column";

}


// Can be found in the widgets folder