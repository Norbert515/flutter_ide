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


class AspectRatioElement extends WidgetElement with SlotChildElementMixin {
  AspectRatioElement({
    @required String id,
    double aspectRatio,
  }) :
    aspectRatio = MDoubleProperty(
        value: aspectRatio?? 16/9,
        name: "aspectRatio",
        defaultValue: 16/9
    ),


      super(id);

    final MDoubleProperty aspectRatio;

    static const String CHILD = "child";

  @override
  List<ChildSlot> constructChildSlots() => [
   SingleChildSlot(slotName: CHILD),
  ];  
  
  @override
  List<MProperty> get attributes => [
    aspectRatio,
  ];

  @override
  Widget generateWidget() {
    return AspectRatioElementWidget(
      id: id,
    );
  }

  factory AspectRatioElement.fromMap(Map<String, dynamic> map) {
    return AspectRatioElement(
        id: map["id"],
        aspectRatio: map["aspectRatio"],
    );
  }

  @override
  String get name => "AspectRatio";

}


 class AspectRatioElementWidget extends StatefulWidget with ElementWidgetMixin {
  AspectRatioElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _AspectRatioElementWidgetState createState() => _AspectRatioElementWidgetState();
}

class _AspectRatioElementWidgetState extends State<AspectRatioElementWidget> with ElementWidgetStateMixin<AspectRatioElement, AspectRatioElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: AspectRatio(
          child: getChildOrDragTarget(
               childId: element.findIdForSlot(AspectRatioElement.CHILD),
               data: SlotData(slotName: AspectRatioElement.CHILD), 
             ),        
         aspectRatio: element.aspectRatio.value,
        )
    );
  }

} 
  