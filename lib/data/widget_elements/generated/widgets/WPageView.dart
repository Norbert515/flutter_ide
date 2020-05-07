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
import 'package:widget_maker_2_0/data/widget_elements/widgets/wpageview.dart';

class WPageViewElement extends WidgetElement with SlotChildElementMixin {
  WPageViewElement({
    @required String id,
    bool pageSnapping,
  }) :
    pageSnapping = MBoolProperty(
        value: pageSnapping?? true,
        name: "pageSnapping",
        defaultValue: true
    ),


      super(id);

    final MBoolProperty pageSnapping;

    static const String CHILDREN = "children";

  @override
  List<ChildSlot> constructChildSlots() => [
   ListChildSlot(slotName: CHILDREN),
  ];  
  
  @override
  List<MProperty> get attributes => [
    pageSnapping,
  ];

  @override
  Widget generateWidget() {
    return PageViewElementWidget(
      id: id,
    );
  }

  factory WPageViewElement.fromMap(Map<String, dynamic> map) {
    return WPageViewElement(
        id: map["id"],
        pageSnapping: map["pageSnapping"],
    );
  }

  @override
  String get name => "PageView";

}


// Can be found in the widgets folder