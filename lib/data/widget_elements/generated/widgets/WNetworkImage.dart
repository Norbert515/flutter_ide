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
import 'package:widget_maker_2_0/data/widget_elements/widgets/wnetworkimage.dart';

class WNetworkImageElement extends WidgetElement with NoChildElementMixin {
  WNetworkImageElement({
    @required String id,
    double width,
    double height,
    String src,
    BoxFit fit,
  }) :
    width = MDoubleProperty(
        value: width?? null,
        name: "width",
        allowNegative: false,
        defaultValue: null
    ),

    height = MDoubleProperty(
        value: height?? null,
        name: "height",
        allowNegative: false,
        defaultValue: null
    ),

    src = MStringProperty(
        value: src?? "https://images.unsplash.com/photo-1558945657-484aa38065ec?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=633&q=80",
        name: "src",
        defaultValue: "https://images.unsplash.com/photo-1558945657-484aa38065ec?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=633&q=80"
    ),

    fit = MBoxFitProperty(
        value: fit?? null,
        name: "fit",
        defaultValue: null
    ),


      super(id);

    final MDoubleProperty width;
    final MDoubleProperty height;
    final MStringProperty src;
    final MBoxFitProperty fit;

  
  @override
  List<MProperty> get attributes => [
    width,
    height,
    src,
    fit,
  ];

  @override
  Widget generateWidget() {
    return ImageElementWidget(
      id: id,
    );
  }

  factory WNetworkImageElement.fromMap(Map<String, dynamic> map) {
    return WNetworkImageElement(
        id: map["id"],
        width: map["width"],
        height: map["height"],
        src: map["src"],
        fit: map["fit"],
    );
  }

  @override
  String get name => "NetworkImage";

}


// Can be found in the widgets folder