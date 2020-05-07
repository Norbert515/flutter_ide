import 'package:widget_maker_2_0/data/properties/offset_property.dart';
import 'package:widget_maker_2_0/data/widget_elements/base/widget_element.dart';
import 'package:widget_maker_2_0/data/widget_elements/generated/properties/objects.dart';
import 'package:widget_maker_2_0/material.dart';
import 'package:widget_maker_2_0/data/properties/basic_properties.dart';
import 'package:widget_maker_2_0/data/properties/meta_properties.dart';
import 'package:widget_maker_2_0/data/string_builder.dart';
import 'package:widget_maker_2_0/data/widget_elements/widgets/meta.dart';



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