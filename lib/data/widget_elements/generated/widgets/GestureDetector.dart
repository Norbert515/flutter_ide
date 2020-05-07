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


class GestureDetectorElement extends WidgetElement with SlotChildElementMixin {
  GestureDetectorElement({
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
    return GestureDetectorElementWidget(
      id: id,
    );
  }

  factory GestureDetectorElement.fromMap(Map<String, dynamic> map) {
    return GestureDetectorElement(
        id: map["id"],
    );
  }

  @override
  String get name => "GestureDetector";

}


 class GestureDetectorElementWidget extends StatefulWidget with ElementWidgetMixin {
  GestureDetectorElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _GestureDetectorElementWidgetState createState() => _GestureDetectorElementWidgetState();
}

class _GestureDetectorElementWidgetState extends State<GestureDetectorElementWidget> with ElementWidgetStateMixin<GestureDetectorElement, GestureDetectorElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: GestureDetector(
          child: getChildOrDragTarget(
               childId: element.findIdForSlot(GestureDetectorElement.CHILD),
               data: SlotData(slotName: GestureDetectorElement.CHILD), 
             ),        

        )
    );
  }

} 
  