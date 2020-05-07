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
import 'package:widget_maker_2_0/data/widget_elements/widgets/textfield.dart';

class TextFieldElement extends WidgetElement with NoChildElementMixin {
  TextFieldElement({
    @required String id,
    bool obscureText,
  }) :
    obscureText = MBoolProperty(
        value: obscureText?? false,
        name: "obscureText",
        defaultValue: false
    ),


      super(id);

    final MBoolProperty obscureText;

  
  @override
  List<MProperty> get attributes => [
    obscureText,
  ];

  @override
  Widget generateWidget() {
    return TextFieldElementWidget(
      id: id,
    );
  }

  factory TextFieldElement.fromMap(Map<String, dynamic> map) {
    return TextFieldElement(
        id: map["id"],
        obscureText: map["obscureText"],
    );
  }

  @override
  String get name => "TextField";

}


// Can be found in the widgets folder