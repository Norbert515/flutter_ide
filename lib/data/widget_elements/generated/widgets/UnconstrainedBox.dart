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


class UnconstrainedBoxElement extends WidgetElement with SlotChildElementMixin {
  UnconstrainedBoxElement({
    @required String id,
    Axis constrainedAxis,
    TextDirection textDirection,
    Alignment alignment,
  }) :
    constrainedAxis = MAxisProperty(
        value: constrainedAxis?? null,
        name: "constrainedAxis",
        defaultValue: null
    ),

    textDirection = MTextDirectionProperty(
        value: textDirection?? null,
        name: "textDirection",
        defaultValue: null
    ),

    alignment = MAlignmentProperty(
        value: alignment?? Alignment.center,
        name: "alignment",
        defaultValue: Alignment.center
    ),


      super(id);

    final MAxisProperty constrainedAxis;
    final MTextDirectionProperty textDirection;
    final MAlignmentProperty alignment;

    static const String CHILD = "child";

  @override
  List<ChildSlot> constructChildSlots() => [
   SingleChildSlot(slotName: CHILD),
  ];  
  
  @override
  List<MProperty> get attributes => [
    constrainedAxis,
    textDirection,
    alignment,
  ];

  @override
  Widget generateWidget() {
    return UnconstrainedBoxElementWidget(
      id: id,
    );
  }

  factory UnconstrainedBoxElement.fromMap(Map<String, dynamic> map) {
    return UnconstrainedBoxElement(
        id: map["id"],
        constrainedAxis: map["constrainedAxis"],
        textDirection: map["textDirection"],
        alignment: map["alignment"],
    );
  }

  @override
  String get name => "UnconstrainedBox";

}


 class UnconstrainedBoxElementWidget extends StatefulWidget with ElementWidgetMixin {
  UnconstrainedBoxElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _UnconstrainedBoxElementWidgetState createState() => _UnconstrainedBoxElementWidgetState();
}

class _UnconstrainedBoxElementWidgetState extends State<UnconstrainedBoxElementWidget> with ElementWidgetStateMixin<UnconstrainedBoxElement, UnconstrainedBoxElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: UnconstrainedBox(
          child: getChildOrDragTarget(
               childId: element.findIdForSlot(UnconstrainedBoxElement.CHILD),
               data: SlotData(slotName: UnconstrainedBoxElement.CHILD), 
             ),        
         constrainedAxis: element.constrainedAxis.value,
         textDirection: element.textDirection.value,
         alignment: element.alignment.value,
        )
    );
  }

} 
  