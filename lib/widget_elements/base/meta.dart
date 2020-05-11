import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/properties/basic_properties.dart';
import 'package:widget_maker_2_0/properties/meta_properties.dart';
import 'package:widget_maker_2_0/properties/offset_property.dart';
import 'package:widget_maker_2_0/widget_elements/base/widget_element.dart';
import 'package:widget_maker_2_0/widget_elements/widgets/meta.dart';



class CanvasElement extends WidgetElement with SingleChildElement {

  CanvasElement({
    @required String id,
    CanvasSize canvasSize = const CanvasSize(
      width: 411,
      height: 731,
    ),
    Offset position = const Offset(16.0, 16.0),
  }) :
      canvasSize = MCanvasSizeProperty(
        name: "canvasSize",
        value: canvasSize,
      ),
      position = MOffsetProperty(
        name: "Position",
        value: position,
      ),
  super(id);


  @override
  bool get isRoot => true;
  
  final MCanvasSizeProperty canvasSize;
  final MOffsetProperty position;

  @override
  List<MProperty> get attributes => [canvasSize, position];

  @override
  Widget generateWidget() {
    return CanvasElementWidget(
      id: id,
    );
  }

  @override
  String get name => "Canvas";

  @override
  String writeCode2(Map<String, WidgetElement> allElements) {
    if(!allElements.containsKey(childId)) {
      return "Text(\"Nothing here yet!\")";
    }
    return allElements[childId].writeCode2(allElements);
  }

}