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
import 'package:widget_maker_2_0/widget_elements/widgets/row.dart';

class RowElement extends WidgetElement with SlotChildElementMixin {
  RowElement({
    @required String id,
    CrossAxisAlignment crossAxisAlignment,
    MainAxisSize mainAxisSize,
    MainAxisAlignment mainAxisAlignment,
    TextBaseline textBaseline,
    TextDirection textDirection,
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

    textBaseline = MTextBaselineProperty(
        value: textBaseline?? null,
        name: "textBaseline",
        defaultValue: null
    ),

    textDirection = MTextDirectionProperty(
        value: textDirection?? null,
        name: "textDirection",
        defaultValue: null
    ),


      super(id);

    final MCrossAxisAlignmentProperty crossAxisAlignment;
    final MMainAxisSizeProperty mainAxisSize;
    final MMainAxisAlignmentProperty mainAxisAlignment;
    final MTextBaselineProperty textBaseline;
    final MTextDirectionProperty textDirection;

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
    textBaseline,
    textDirection,
  ];

  @override
  Widget generateWidget() {
    return RowElementWidget(
      id: id,
    );
  }

  factory RowElement.fromMap(Map<String, dynamic> map) {
    return RowElement(
        id: map["id"],
        crossAxisAlignment: map["crossAxisAlignment"],
        mainAxisSize: map["mainAxisSize"],
        mainAxisAlignment: map["mainAxisAlignment"],
        textBaseline: map["textBaseline"],
        textDirection: map["textDirection"],
    );
  }

  @override
  String get name => "Row";

}


// Can be found in the widgets folder