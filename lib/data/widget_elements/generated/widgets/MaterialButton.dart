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


class MaterialButtonElement extends WidgetElement with SlotChildElementMixin {
  MaterialButtonElement({
    @required String id,
    Color color,
    double elevation,
    EdgeInsets padding,
  }) :
    color = MColorProperty(
        value: color?? null,
        name: "color",
        defaultValue: null
    ),

    elevation = MDoubleProperty(
        value: elevation?? null,
        name: "elevation",
        defaultValue: null
    ),

    padding = MEdgeInsetsProperty(
        value: padding?? null,
        name: "padding",
        defaultValue: null
    ),


      super(id);

    final MColorProperty color;
    final MDoubleProperty elevation;
    final MEdgeInsetsProperty padding;

    static const String CHILD = "child";

  @override
  List<ChildSlot> constructChildSlots() => [
   SingleChildSlot(slotName: CHILD),
  ];  
  
  @override
  List<MProperty> get attributes => [
    color,
    elevation,
    padding,
  ];

  @override
  Widget generateWidget() {
    return MaterialButtonElementWidget(
      id: id,
    );
  }

  factory MaterialButtonElement.fromMap(Map<String, dynamic> map) {
    return MaterialButtonElement(
        id: map["id"],
        color: map["color"],
        elevation: map["elevation"],
        padding: map["padding"],
    );
  }

  @override
  String get name => "MaterialButton";

}


 class MaterialButtonElementWidget extends StatefulWidget with ElementWidgetMixin {
  MaterialButtonElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _MaterialButtonElementWidgetState createState() => _MaterialButtonElementWidgetState();
}

class _MaterialButtonElementWidgetState extends State<MaterialButtonElementWidget> with ElementWidgetStateMixin<MaterialButtonElement, MaterialButtonElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: MaterialButton(
          child: getChildOrDragTarget(
               childId: element.findIdForSlot(MaterialButtonElement.CHILD),
               data: SlotData(slotName: MaterialButtonElement.CHILD), 
               widgetWrapper: (context, child) => sizeWidgetWrapper(context, Size(100.0,60.0), child)
             ),        
         color: element.color.value,
         elevation: element.elevation.value,
         padding: element.padding.value,
        )
    );
  }

} 
  