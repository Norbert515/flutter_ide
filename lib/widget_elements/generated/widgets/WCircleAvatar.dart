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
import 'package:widget_maker_2_0/widget_elements/widgets/wcircleavatar.dart';

class WCircleAvatarElement extends WidgetElement with SlotChildElementMixin {
  WCircleAvatarElement({
    @required String id,
    double radius,
    String imageUrl,
  }) :
    radius = MDoubleProperty(
        value: radius?? 32,
        name: "radius",
        defaultValue: 32
    ),

    imageUrl = MStringProperty(
        value: imageUrl?? "https://images.unsplash.com/photo-1537815749002-de6a533c64db?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=845&q=80",
        name: "imageUrl",
        defaultValue: "https://images.unsplash.com/photo-1537815749002-de6a533c64db?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=845&q=80"
    ),


      super(id);

    final MDoubleProperty radius;
    final MStringProperty imageUrl;

    static const String CHILD = "child";

  @override
  List<ChildSlot> constructChildSlots() => [
   SingleChildSlot(slotName: CHILD),
  ];  
  
  @override
  List<MProperty> get attributes => [
    radius,
    imageUrl,
  ];

  @override
  Widget generateWidget() {
    return CircleAvatarElementWidget(
      id: id,
    );
  }

  factory WCircleAvatarElement.fromMap(Map<String, dynamic> map) {
    return WCircleAvatarElement(
        id: map["id"],
        radius: map["radius"],
        imageUrl: map["imageUrl"],
    );
  }

  @override
  String get name => "CircleAvatar";

}


// Can be found in the widgets folder