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


class OutlineButtonElement extends WidgetElement with SlotChildElementMixin {
  OutlineButtonElement({
    @required String id,
    Color color,
    EdgeInsets padding,
  }) :
    color = MColorProperty(
        value: color?? null,
        name: "color",
        defaultValue: null
    ),

    padding = MEdgeInsetsProperty(
        value: padding?? null,
        name: "padding",
        defaultValue: null
    ),


      super(id);

    final MColorProperty color;
    final MEdgeInsetsProperty padding;

    static const String CHILD = "child";

  @override
  List<ChildSlot> constructChildSlots() => [
   SingleChildSlot(slotName: CHILD),
  ];  
  
  @override
  List<MProperty> get attributes => [
    color,
    padding,
  ];

  @override
  Widget generateWidget() {
    return OutlineButtonElementWidget(
      id: id,
    );
  }

  factory OutlineButtonElement.fromMap(Map<String, dynamic> map) {
    return OutlineButtonElement(
        id: map["id"],
        color: map["color"],
        padding: map["padding"],
    );
  }

  @override
  String get name => "OutlineButton";

}


 class OutlineButtonElementWidget extends StatefulWidget with ElementWidgetMixin {
  OutlineButtonElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _OutlineButtonElementWidgetState createState() => _OutlineButtonElementWidgetState();
}

class _OutlineButtonElementWidgetState extends State<OutlineButtonElementWidget> with ElementWidgetStateMixin<OutlineButtonElement, OutlineButtonElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: OutlineButton(
          child: getChildOrDragTarget(
               childId: element.findIdForSlot(OutlineButtonElement.CHILD),
               data: SlotData(slotName: OutlineButtonElement.CHILD), 
               widgetWrapper: (context, child) => sizeWidgetWrapper(context, Size(100.0,60.0), child)
             ),        
         color: element.color.value,
         padding: element.padding.value,
        )
    );
  }

} 
  