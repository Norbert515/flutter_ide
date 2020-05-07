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


class RotatedBoxElement extends WidgetElement with SlotChildElementMixin {
  RotatedBoxElement({
    @required String id,
    int quarterTurns,
  }) :
    quarterTurns = MIntProperty(
        value: quarterTurns?? 0,
        name: "quarterTurns",
        defaultValue: 0
    ),


      super(id);

    final MIntProperty quarterTurns;

    static const String CHILD = "child";

  @override
  List<ChildSlot> constructChildSlots() => [
   SingleChildSlot(slotName: CHILD),
  ];  
  
  @override
  List<MProperty> get attributes => [
    quarterTurns,
  ];

  @override
  Widget generateWidget() {
    return RotatedBoxElementWidget(
      id: id,
    );
  }

  factory RotatedBoxElement.fromMap(Map<String, dynamic> map) {
    return RotatedBoxElement(
        id: map["id"],
        quarterTurns: map["quarterTurns"],
    );
  }

  @override
  String get name => "RotatedBox";

}


 class RotatedBoxElementWidget extends StatefulWidget with ElementWidgetMixin {
  RotatedBoxElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _RotatedBoxElementWidgetState createState() => _RotatedBoxElementWidgetState();
}

class _RotatedBoxElementWidgetState extends State<RotatedBoxElementWidget> with ElementWidgetStateMixin<RotatedBoxElement, RotatedBoxElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: RotatedBox(
          child: getChildOrDragTarget(
               childId: element.findIdForSlot(RotatedBoxElement.CHILD),
               data: SlotData(slotName: RotatedBoxElement.CHILD), 
             ),        
         quarterTurns: element.quarterTurns.value,
        )
    );
  }

} 
  