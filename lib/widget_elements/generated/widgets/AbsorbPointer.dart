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


class AbsorbPointerElement extends WidgetElement with SlotChildElementMixin {
  AbsorbPointerElement({
    @required String id,
  }) :

      super(id);


    static const String CHILD = "child";

  @override
  List<ChildSlot> constructChildSlots() => [
   SingleChildSlot(slotName: CHILD),
  ];  
  
  @override
  List<MProperty> get attributes => [
  ];

  @override
  Widget generateWidget() {
    return AbsorbPointerElementWidget(
      id: id,
    );
  }

  factory AbsorbPointerElement.fromMap(Map<String, dynamic> map) {
    return AbsorbPointerElement(
        id: map["id"],
    );
  }

  @override
  String get name => "AbsorbPointer";

}


 class AbsorbPointerElementWidget extends StatefulWidget with ElementWidgetMixin {
  AbsorbPointerElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _AbsorbPointerElementWidgetState createState() => _AbsorbPointerElementWidgetState();
}

class _AbsorbPointerElementWidgetState extends State<AbsorbPointerElementWidget> with ElementWidgetStateMixin<AbsorbPointerElement, AbsorbPointerElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: AbsorbPointer(
          child: getChildOrDragTarget(
               childId: element.findIdForSlot(AbsorbPointerElement.CHILD),
               data: SlotData(slotName: AbsorbPointerElement.CHILD), 
             ),        

        )
    );
  }

} 
  