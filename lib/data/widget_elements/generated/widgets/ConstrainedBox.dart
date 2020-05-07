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


class ConstrainedBoxElement extends WidgetElement with SlotChildElementMixin {
  ConstrainedBoxElement({
    @required String id,
    BoxConstraints constraints,
  }) :
    constraints = MBoxConstraintsProperty(
        value: constraints?? const BoxConstraints(),
        name: "constraints",
        defaultValue: const BoxConstraints()
    ),


      super(id);

    final MBoxConstraintsProperty constraints;

    static const String CHILD = "child";

  @override
  List<ChildSlot> constructChildSlots() => [
   SingleChildSlot(slotName: CHILD),
  ];  
  
  @override
  List<MProperty> get attributes => [
    constraints,
  ];

  @override
  Widget generateWidget() {
    return ConstrainedBoxElementWidget(
      id: id,
    );
  }

  factory ConstrainedBoxElement.fromMap(Map<String, dynamic> map) {
    return ConstrainedBoxElement(
        id: map["id"],
        constraints: map["constraints"],
    );
  }

  @override
  String get name => "ConstrainedBox";

}


 class ConstrainedBoxElementWidget extends StatefulWidget with ElementWidgetMixin {
  ConstrainedBoxElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _ConstrainedBoxElementWidgetState createState() => _ConstrainedBoxElementWidgetState();
}

class _ConstrainedBoxElementWidgetState extends State<ConstrainedBoxElementWidget> with ElementWidgetStateMixin<ConstrainedBoxElement, ConstrainedBoxElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: ConstrainedBox(
          child: getChildOrDragTarget(
               childId: element.findIdForSlot(ConstrainedBoxElement.CHILD),
               data: SlotData(slotName: ConstrainedBoxElement.CHILD), 
             ),        
         constraints: element.constraints.value,
        )
    );
  }

} 
  