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
import 'package:widget_maker_2_0/widget_elements/widgets/expanded.dart';

class ExpandedElement extends WidgetElement with SlotChildElementMixin {
  ExpandedElement({
    @required String id,
    int flex,
  }) :
    flex = MIntProperty(
        value: flex?? 1,
        name: "flex",
        defaultValue: 1
    ),


      super(id);

    final MIntProperty flex;

    static const String CHILD = "child";

  @override
  List<ChildSlot> constructChildSlots() => [
   SingleChildSlot(slotName: CHILD),
  ];  
  
  @override
  List<MProperty> get attributes => [
    flex,
  ];

  @override
  Widget generateWidget() {
    return ExpandedElementWidget(
      id: id,
    );
  }

  factory ExpandedElement.fromMap(Map<String, dynamic> map) {
    return ExpandedElement(
        id: map["id"],
        flex: map["flex"],
    );
  }

  @override
  String get name => "Expanded";

}


// Can be found in the widgets folder