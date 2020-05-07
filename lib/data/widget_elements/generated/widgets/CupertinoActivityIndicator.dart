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


class CupertinoActivityIndicatorElement extends WidgetElement with NoChildElementMixin {
  CupertinoActivityIndicatorElement({
    @required String id,
    bool animating,
    double radius,
  }) :
    animating = MBoolProperty(
        value: animating?? true,
        name: "animating",
        defaultValue: true
    ),

    radius = MDoubleProperty(
        value: radius?? 10.0,
        name: "radius",
        defaultValue: 10.0
    ),


      super(id);

    final MBoolProperty animating;
    final MDoubleProperty radius;

  
  @override
  List<MProperty> get attributes => [
    animating,
    radius,
  ];

  @override
  Widget generateWidget() {
    return CupertinoActivityIndicatorElementWidget(
      id: id,
    );
  }

  factory CupertinoActivityIndicatorElement.fromMap(Map<String, dynamic> map) {
    return CupertinoActivityIndicatorElement(
        id: map["id"],
        animating: map["animating"],
        radius: map["radius"],
    );
  }

  @override
  String get name => "CupertinoActivityIndicator";

}


 class CupertinoActivityIndicatorElementWidget extends StatefulWidget with ElementWidgetMixin {
  CupertinoActivityIndicatorElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _CupertinoActivityIndicatorElementWidgetState createState() => _CupertinoActivityIndicatorElementWidgetState();
}

class _CupertinoActivityIndicatorElementWidgetState extends State<CupertinoActivityIndicatorElementWidget> with ElementWidgetStateMixin<CupertinoActivityIndicatorElement, CupertinoActivityIndicatorElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: CupertinoActivityIndicator(
        
         animating: element.animating.value,
         radius: element.radius.value,
        )
    );
  }

} 
  