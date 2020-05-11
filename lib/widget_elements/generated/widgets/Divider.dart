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


class DividerElement extends WidgetElement with NoChildElementMixin {
  DividerElement({
    @required String id,
    double height,
    double indent,
    double endIndent,
    Color color,
  }) :
    height = MDoubleProperty(
        value: height?? 16,
        name: "height",
        defaultValue: 16
    ),

    indent = MDoubleProperty(
        value: indent?? 0,
        name: "indent",
        defaultValue: 0
    ),

    endIndent = MDoubleProperty(
        value: endIndent?? 0,
        name: "endIndent",
        defaultValue: 0
    ),

    color = MColorProperty(
        value: color?? null,
        name: "color",
        defaultValue: null
    ),


      super(id);

    final MDoubleProperty height;
    final MDoubleProperty indent;
    final MDoubleProperty endIndent;
    final MColorProperty color;

  
  @override
  List<MProperty> get attributes => [
    height,
    indent,
    endIndent,
    color,
  ];

  @override
  Widget generateWidget() {
    return DividerElementWidget(
      id: id,
    );
  }

  factory DividerElement.fromMap(Map<String, dynamic> map) {
    return DividerElement(
        id: map["id"],
        height: map["height"],
        indent: map["indent"],
        endIndent: map["endIndent"],
        color: map["color"],
    );
  }

  @override
  String get name => "Divider";

}


 class DividerElementWidget extends StatefulWidget with ElementWidgetMixin {
  DividerElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _DividerElementWidgetState createState() => _DividerElementWidgetState();
}

class _DividerElementWidgetState extends State<DividerElementWidget> with ElementWidgetStateMixin<DividerElement, DividerElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: Divider(
        
         height: element.height.value,
         indent: element.indent.value,
         endIndent: element.endIndent.value,
         color: element.color.value,
        )
    );
  }

} 
  