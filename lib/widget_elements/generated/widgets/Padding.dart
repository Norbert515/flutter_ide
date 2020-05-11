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


class PaddingElement extends WidgetElement with SlotChildElementMixin {
  PaddingElement({
    @required String id,
    EdgeInsets padding,
  }) :
    padding = MEdgeInsetsProperty(
        value: padding?? const EdgeInsets.all(0),
        name: "padding",
        defaultValue: const EdgeInsets.all(0)
    ),


      super(id);

    final MEdgeInsetsProperty padding;

    static const String CHILD = "child";

  @override
  List<ChildSlot> constructChildSlots() => [
   SingleChildSlot(slotName: CHILD),
  ];  
  
  @override
  List<MProperty> get attributes => [
    padding,
  ];

  @override
  Widget generateWidget() {
    return PaddingElementWidget(
      id: id,
    );
  }

  factory PaddingElement.fromMap(Map<String, dynamic> map) {
    return PaddingElement(
        id: map["id"],
        padding: map["padding"],
    );
  }

  @override
  String get name => "Padding";

}


 class PaddingElementWidget extends StatefulWidget with ElementWidgetMixin {
  PaddingElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _PaddingElementWidgetState createState() => _PaddingElementWidgetState();
}

class _PaddingElementWidgetState extends State<PaddingElementWidget> with ElementWidgetStateMixin<PaddingElement, PaddingElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: Padding(
          child: getChildOrDragTarget(
               childId: element.findIdForSlot(PaddingElement.CHILD),
               data: SlotData(slotName: PaddingElement.CHILD), 
             ),        
         padding: element.padding.value,
        )
    );
  }

} 
  