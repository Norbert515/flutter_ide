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


class SizedBoxElement extends WidgetElement with SlotChildElementMixin {
  SizedBoxElement({
    @required String id,
    double width,
    double height,
  }) :
    width = MDoubleProperty(
        value: width?? 100,
        name: "width",
        allowNegative: false,
        defaultValue: 100
    ),

    height = MDoubleProperty(
        value: height?? 100,
        name: "height",
        allowNegative: false,
        defaultValue: 100
    ),


      super(id);

    final MDoubleProperty width;
    final MDoubleProperty height;

    static const String CHILD = "child";

  @override
  List<ChildSlot> constructChildSlots() => [
   SingleChildSlot(slotName: CHILD),
  ];  
  
  @override
  List<MProperty> get attributes => [
    width,
    height,
  ];

  @override
  Widget generateWidget() {
    return SizedBoxElementWidget(
      id: id,
    );
  }

  factory SizedBoxElement.fromMap(Map<String, dynamic> map) {
    return SizedBoxElement(
        id: map["id"],
        width: map["width"],
        height: map["height"],
    );
  }

  @override
  String get name => "SizedBox";

}


 class SizedBoxElementWidget extends StatefulWidget with ElementWidgetMixin {
  SizedBoxElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _SizedBoxElementWidgetState createState() => _SizedBoxElementWidgetState();
}

class _SizedBoxElementWidgetState extends State<SizedBoxElementWidget> with ElementWidgetStateMixin<SizedBoxElement, SizedBoxElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: SizedBox(
          child: getChildOrDragTarget(
               childId: element.findIdForSlot(SizedBoxElement.CHILD),
               data: SlotData(slotName: SizedBoxElement.CHILD), 
             ),        
         width: element.width.value,
         height: element.height.value,
        )
    );
  }

} 
  