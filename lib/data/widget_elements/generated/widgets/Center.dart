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


class CenterElement extends WidgetElement with SlotChildElementMixin {
  CenterElement({
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
    return CenterElementWidget(
      id: id,
    );
  }

  factory CenterElement.fromMap(Map<String, dynamic> map) {
    return CenterElement(
        id: map["id"],
    );
  }

  @override
  String get name => "Center";

}


 class CenterElementWidget extends StatefulWidget with ElementWidgetMixin {
  CenterElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _CenterElementWidgetState createState() => _CenterElementWidgetState();
}

class _CenterElementWidgetState extends State<CenterElementWidget> with ElementWidgetStateMixin<CenterElement, CenterElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: Center(
          child: getChildOrDragTarget(
               childId: element.findIdForSlot(CenterElement.CHILD),
               data: SlotData(slotName: CenterElement.CHILD), 
             ),        

        )
    );
  }

} 
  