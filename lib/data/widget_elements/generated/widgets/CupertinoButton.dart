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


class CupertinoButtonElement extends WidgetElement with SlotChildElementMixin {
  CupertinoButtonElement({
    @required String id,
    Color color,
    Color disabledColor,
    double minSize,
    EdgeInsets padding,
    double pressedOpacity,
  }) :
    color = MColorProperty(
        value: color?? null,
        name: "color",
        defaultValue: null
    ),

    disabledColor = MColorProperty(
        value: disabledColor?? null,
        name: "disabledColor",
        defaultValue: null
    ),

    minSize = MDoubleProperty(
        value: minSize?? null,
        name: "minSize",
        defaultValue: null
    ),

    padding = MEdgeInsetsProperty(
        value: padding?? null,
        name: "padding",
        defaultValue: null
    ),

    pressedOpacity = MDoubleProperty(
        value: pressedOpacity?? null,
        name: "pressedOpacity",
        defaultValue: null
    ),


      super(id);

    final MColorProperty color;
    final MColorProperty disabledColor;
    final MDoubleProperty minSize;
    final MEdgeInsetsProperty padding;
    final MDoubleProperty pressedOpacity;

    static const String CHILD = "child";

  @override
  List<ChildSlot> constructChildSlots() => [
   SingleChildSlot(slotName: CHILD),
  ];  
  
  @override
  List<MProperty> get attributes => [
    color,
    disabledColor,
    minSize,
    padding,
    pressedOpacity,
  ];

  @override
  Widget generateWidget() {
    return CupertinoButtonElementWidget(
      id: id,
    );
  }

  factory CupertinoButtonElement.fromMap(Map<String, dynamic> map) {
    return CupertinoButtonElement(
        id: map["id"],
        color: map["color"],
        disabledColor: map["disabledColor"],
        minSize: map["minSize"],
        padding: map["padding"],
        pressedOpacity: map["pressedOpacity"],
    );
  }

  @override
  String get name => "CupertinoButton";

}


 class CupertinoButtonElementWidget extends StatefulWidget with ElementWidgetMixin {
  CupertinoButtonElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _CupertinoButtonElementWidgetState createState() => _CupertinoButtonElementWidgetState();
}

class _CupertinoButtonElementWidgetState extends State<CupertinoButtonElementWidget> with ElementWidgetStateMixin<CupertinoButtonElement, CupertinoButtonElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: CupertinoButton(
          child: getChildOrDragTarget(
               childId: element.findIdForSlot(CupertinoButtonElement.CHILD),
               data: SlotData(slotName: CupertinoButtonElement.CHILD), 
               widgetWrapper: (context, child) => sizeWidgetWrapper(context, Size(100.0,60.0), child)
             ),        
         color: element.color.value,
         disabledColor: element.disabledColor.value,
         minSize: element.minSize.value,
         padding: element.padding.value,
         pressedOpacity: element.pressedOpacity.value,
        )
    );
  }

} 
  