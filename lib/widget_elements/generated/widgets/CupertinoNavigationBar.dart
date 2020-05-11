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


class CupertinoNavigationBarElement extends WidgetElement with SlotChildElementMixin {
  CupertinoNavigationBarElement({
    @required String id,
    Color backgroundColor,
  }) :
    backgroundColor = MColorProperty(
        value: backgroundColor?? null,
        name: "backgroundColor",
        defaultValue: null
    ),


      super(id);

    final MColorProperty backgroundColor;

    static const String LEADING = "leading";
  static const String MIDDLE = "middle";
  static const String TRAILING = "trailing";

  @override
  List<ChildSlot> constructChildSlots() => [
   SingleChildSlot(slotName: LEADING),
   SingleChildSlot(slotName: MIDDLE),
   SingleChildSlot(slotName: TRAILING),
  ];  
  
  @override
  List<MProperty> get attributes => [
    backgroundColor,
  ];

  @override
  Widget generateWidget() {
    return CupertinoNavigationBarElementWidget(
      id: id,
    );
  }

  factory CupertinoNavigationBarElement.fromMap(Map<String, dynamic> map) {
    return CupertinoNavigationBarElement(
        id: map["id"],
        backgroundColor: map["backgroundColor"],
    );
  }

  @override
  String get name => "CupertinoNavigationBar";

}


 class CupertinoNavigationBarElementWidget extends StatefulWidget with ElementWidgetMixin {
  CupertinoNavigationBarElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _CupertinoNavigationBarElementWidgetState createState() => _CupertinoNavigationBarElementWidgetState();
}

class _CupertinoNavigationBarElementWidgetState extends State<CupertinoNavigationBarElementWidget> with ElementWidgetStateMixin<CupertinoNavigationBarElement, CupertinoNavigationBarElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: CupertinoNavigationBar(
          leading: getChildOrDragTarget(
               childId: element.findIdForSlot(CupertinoNavigationBarElement.LEADING),
               data: SlotData(slotName: CupertinoNavigationBarElement.LEADING), 
             ),          middle: getChildOrDragTarget(
               childId: element.findIdForSlot(CupertinoNavigationBarElement.MIDDLE),
               data: SlotData(slotName: CupertinoNavigationBarElement.MIDDLE), 
             ),          trailing: getChildOrDragTarget(
               childId: element.findIdForSlot(CupertinoNavigationBarElement.TRAILING),
               data: SlotData(slotName: CupertinoNavigationBarElement.TRAILING), 
             ),        
         backgroundColor: element.backgroundColor.value,
        )
    );
  }

} 
  