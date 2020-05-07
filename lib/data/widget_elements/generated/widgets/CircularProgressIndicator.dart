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


class CircularProgressIndicatorElement extends WidgetElement with NoChildElementMixin {
  CircularProgressIndicatorElement({
    @required String id,
    double strokeWidth,
    Color backgroundColor,
  }) :
    strokeWidth = MDoubleProperty(
        value: strokeWidth?? 4,
        name: "strokeWidth",
        defaultValue: 4
    ),

    backgroundColor = MColorProperty(
        value: backgroundColor?? null,
        name: "backgroundColor",
        defaultValue: null
    ),


      super(id);

    final MDoubleProperty strokeWidth;
    final MColorProperty backgroundColor;

  
  @override
  List<MProperty> get attributes => [
    strokeWidth,
    backgroundColor,
  ];

  @override
  Widget generateWidget() {
    return CircularProgressIndicatorElementWidget(
      id: id,
    );
  }

  factory CircularProgressIndicatorElement.fromMap(Map<String, dynamic> map) {
    return CircularProgressIndicatorElement(
        id: map["id"],
        strokeWidth: map["strokeWidth"],
        backgroundColor: map["backgroundColor"],
    );
  }

  @override
  String get name => "CircularProgressIndicator";

}


 class CircularProgressIndicatorElementWidget extends StatefulWidget with ElementWidgetMixin {
  CircularProgressIndicatorElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _CircularProgressIndicatorElementWidgetState createState() => _CircularProgressIndicatorElementWidgetState();
}

class _CircularProgressIndicatorElementWidgetState extends State<CircularProgressIndicatorElementWidget> with ElementWidgetStateMixin<CircularProgressIndicatorElement, CircularProgressIndicatorElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: CircularProgressIndicator(
        
         strokeWidth: element.strokeWidth.value,
         backgroundColor: element.backgroundColor.value,
        )
    );
  }

} 
  