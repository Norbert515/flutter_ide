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


class WAnimatedContainerElement extends WidgetElement with SlotChildElementMixin {
  WAnimatedContainerElement({
    @required String id,
    WDuration duration,
    double width,
    double height,
    Color color,
    Alignment alignment,
    EdgeInsets padding,
    Decoration decoration,
    Decoration foregroundDecoration,
    BoxConstraints constraints,
    EdgeInsets margin,
    Matrix4 transform,
  }) :
    duration = MWDurationProperty(
        value: duration?? const WDuration(seconds:1),
        name: "duration",
        defaultValue: const WDuration(seconds:1)
    ),

    width = MDoubleProperty(
        value: width?? null,
        name: "width",
        defaultValue: null
    ),

    height = MDoubleProperty(
        value: height?? null,
        name: "height",
        defaultValue: null
    ),

    color = MColorProperty(
        value: color?? null,
        name: "color",
        defaultValue: null
    ),

    alignment = MAlignmentProperty(
        value: alignment?? Alignment.center,
        name: "alignment",
        defaultValue: Alignment.center
    ),

    padding = MEdgeInsetsProperty(
        value: padding?? const EdgeInsets.all(0),
        name: "padding",
        defaultValue: const EdgeInsets.all(0)
    ),

    decoration = MDecorationProperty(
        value: decoration?? null,
        name: "decoration",
        defaultValue: null
    ),

    foregroundDecoration = MDecorationProperty(
        value: foregroundDecoration?? null,
        name: "foregroundDecoration",
        defaultValue: null
    ),

    constraints = MBoxConstraintsProperty(
        value: constraints?? null,
        name: "constraints",
        defaultValue: null
    ),

    margin = MEdgeInsetsProperty(
        value: margin?? null,
        name: "margin",
        defaultValue: null
    ),

    transform = MWIPProperty<Matrix4>(
        value: transform?? null,
        name: "transform",
        defaultValue: null
    ),


      super(id);

    final MWDurationProperty duration;
    final MDoubleProperty width;
    final MDoubleProperty height;
    final MColorProperty color;
    final MAlignmentProperty alignment;
    final MEdgeInsetsProperty padding;
    final MDecorationProperty decoration;
    final MDecorationProperty foregroundDecoration;
    final MBoxConstraintsProperty constraints;
    final MEdgeInsetsProperty margin;
    final MWIPProperty<Matrix4> transform;

    static const String CHILD = "child";

  @override
  List<ChildSlot> constructChildSlots() => [
   SingleChildSlot(slotName: CHILD),
  ];  
  
  @override
  List<MProperty> get attributes => [
    duration,
    width,
    height,
    color,
    alignment,
    padding,
    decoration,
    foregroundDecoration,
    constraints,
    margin,
    transform,
  ];

  @override
  Widget generateWidget() {
    return WAnimatedContainerElementWidget(
      id: id,
    );
  }

  factory WAnimatedContainerElement.fromMap(Map<String, dynamic> map) {
    return WAnimatedContainerElement(
        id: map["id"],
        duration: map["duration"],
        width: map["width"],
        height: map["height"],
        color: map["color"],
        alignment: map["alignment"],
        padding: map["padding"],
        decoration: map["decoration"],
        foregroundDecoration: map["foregroundDecoration"],
        constraints: map["constraints"],
        margin: map["margin"],
        transform: map["transform"],
    );
  }

  @override
  String get name => "AnimatedContainer";

}


 class WAnimatedContainerElementWidget extends StatefulWidget with ElementWidgetMixin {
  WAnimatedContainerElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _WAnimatedContainerElementWidgetState createState() => _WAnimatedContainerElementWidgetState();
}

class _WAnimatedContainerElementWidgetState extends State<WAnimatedContainerElementWidget> with ElementWidgetStateMixin<WAnimatedContainerElement, WAnimatedContainerElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: WAnimatedContainer(
          child: getChildOrDragTarget(
               childId: element.findIdForSlot(WAnimatedContainerElement.CHILD),
               data: SlotData(slotName: WAnimatedContainerElement.CHILD), 
             ),        
         duration: element.duration.value,
         width: element.width.value,
         height: element.height.value,
         color: element.color.value,
         alignment: element.alignment.value,
         padding: element.padding.value,
         decoration: element.decoration.value,
         foregroundDecoration: element.foregroundDecoration.value,
         constraints: element.constraints.value,
         margin: element.margin.value,
         transform: element.transform.value,
        )
    );
  }

} 
  