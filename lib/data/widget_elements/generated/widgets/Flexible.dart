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


class FlexibleElement extends WidgetElement with SlotChildElementMixin {
  FlexibleElement({
    @required String id,
    int flex,
  }) :
    flex = MIntProperty(
        value: flex?? null,
        name: "flex",
        defaultValue: null
    ),


      super(id);

    final MIntProperty flex;

    static const String CHILD = "child";

  @override
  List<ChildSlot> constructChildSlots() => [
   SingleChildSlot(slotName: CHILD),
  ];  
  
  @override
  List<MProperty> get attributes => [
    flex,
  ];

  @override
  Widget generateWidget() {
    return FlexibleElementWidget(
      id: id,
    );
  }

  factory FlexibleElement.fromMap(Map<String, dynamic> map) {
    return FlexibleElement(
        id: map["id"],
        flex: map["flex"],
    );
  }

  @override
  String get name => "Flexible";

}


 class FlexibleElementWidget extends StatefulWidget with ElementWidgetMixin {
  FlexibleElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _FlexibleElementWidgetState createState() => _FlexibleElementWidgetState();
}

class _FlexibleElementWidgetState extends State<FlexibleElementWidget> with ElementWidgetStateMixin<FlexibleElement, FlexibleElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: Flexible(
          child: getChildOrDragTarget(
               childId: element.findIdForSlot(FlexibleElement.CHILD),
               data: SlotData(slotName: FlexibleElement.CHILD), 
             ),        
         flex: element.flex.value,
        )
    );
  }

} 
  