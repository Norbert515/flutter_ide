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


class IconElement extends WidgetElement with NoChildElementMixin {
  IconElement({
    @required String id,
    IconData icon,
    double size,
    Color color,
  }) :
    icon = MIconDataProperty(
        value: icon?? Icons.add,
        name: "icon",
        isRequired: true,
        isNamed: false,
        defaultValue: Icons.add
    ),

    size = MDoubleProperty(
        value: size?? null,
        name: "size",
        defaultValue: null
    ),

    color = MColorProperty(
        value: color?? null,
        name: "color",
        defaultValue: null
    ),


      super(id);

    final MIconDataProperty icon;
    final MDoubleProperty size;
    final MColorProperty color;

  
  @override
  List<MProperty> get attributes => [
    icon,
    size,
    color,
  ];

  @override
  Widget generateWidget() {
    return IconElementWidget(
      id: id,
    );
  }

  factory IconElement.fromMap(Map<String, dynamic> map) {
    return IconElement(
        id: map["id"],
        icon: map["icon"],
        size: map["size"],
        color: map["color"],
    );
  }

  @override
  String get name => "Icon";

}


 class IconElementWidget extends StatefulWidget with ElementWidgetMixin {
  IconElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _IconElementWidgetState createState() => _IconElementWidgetState();
}

class _IconElementWidgetState extends State<IconElementWidget> with ElementWidgetStateMixin<IconElement, IconElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: Icon(
        
         element.icon.value,
         size: element.size.value,
         color: element.color.value,
        )
    );
  }

} 
  