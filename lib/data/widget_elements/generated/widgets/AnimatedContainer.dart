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


class AnimatedContainerElement extends WidgetElement with SingleChildElement {
  AnimatedContainerElement({
    @required String id,
        WDuration duration = const WDuration(seconds:1),
        double width,
        double height,
        Color color = Colors.indigo,
        Alignment alignment = Alignment.center,
        EdgeInsets padding = const EdgeInsets.all(0),
        Decoration decoration,
        Decoration foregroundDecoration,
        BoxConstraints constraints,
        EdgeInsets margin,
        Matrix4 transform,
  }) :
    duration = MWDurationProperty(
        value: duration,
        name: "duration",
    ),
    width = MDoubleProperty(
        value: width,
        name: "width",
    ),
    height = MDoubleProperty(
        value: height,
        name: "height",
    ),
    color = MColorProperty(
        value: color,
        name: "color",
    ),
    alignment = MAlignmentProperty(
        value: alignment,
        name: "alignment",
    ),
    padding = MEdgeInsetsProperty(
        value: padding,
        name: "padding",
    ),
    decoration = MDecorationProperty(
        value: decoration,
        name: "decoration",
    ),
    foregroundDecoration = MDecorationProperty(
        value: foregroundDecoration,
        name: "foregroundDecoration",
    ),
    constraints = MBoxConstraintsProperty(
        value: constraints,
        name: "constraints",
    ),
    margin = MEdgeInsetsProperty(
        value: margin,
        name: "margin",
    ),
    transform = MWIPProperty<Matrix4>(
        value: transform,
        name: "transform",
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
    return AnimatedContainerElementWidget(
      id: id,
    );
  }

  factory AnimatedContainerElement.fromMap(Map<String, dynamic> map) {
    return AnimatedContainerElement(
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


 class AnimatedContainerElementWidget extends StatefulWidget with ElementWidgetMixin {
  AnimatedContainerElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _AnimatedContainerElementWidgetState createState() => _AnimatedContainerElementWidgetState();
}

class _AnimatedContainerElementWidgetState extends State<AnimatedContainerElementWidget> with ElementWidgetStateMixin<AnimatedContainerElement, AnimatedContainerElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: AnimatedContainer(
          child: getChildOrDragTarget(
               childId: element.childId,
               data: null, 
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
  