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


class FractionallySizedBoxElement extends WidgetElement with SlotChildElementMixin {
  FractionallySizedBoxElement({
    @required String id,
    double heightFactor,
    double widthFactor,
    Alignment alignment,
  }) :
    heightFactor = MDoubleProperty(
        value: heightFactor?? null,
        name: "heightFactor",
        allowNegative: false,
        defaultValue: null
    ),

    widthFactor = MDoubleProperty(
        value: widthFactor?? null,
        name: "widthFactor",
        allowNegative: false,
        defaultValue: null
    ),

    alignment = MAlignmentProperty(
        value: alignment?? Alignment.center,
        name: "alignment",
        defaultValue: Alignment.center
    ),


      super(id);

    final MDoubleProperty heightFactor;
    final MDoubleProperty widthFactor;
    final MAlignmentProperty alignment;

    static const String CHILD = "child";

  @override
  List<ChildSlot> constructChildSlots() => [
   SingleChildSlot(slotName: CHILD),
  ];  
  
  @override
  List<MProperty> get attributes => [
    heightFactor,
    widthFactor,
    alignment,
  ];

  @override
  Widget generateWidget() {
    return FractionallySizedBoxElementWidget(
      id: id,
    );
  }

  factory FractionallySizedBoxElement.fromMap(Map<String, dynamic> map) {
    return FractionallySizedBoxElement(
        id: map["id"],
        heightFactor: map["heightFactor"],
        widthFactor: map["widthFactor"],
        alignment: map["alignment"],
    );
  }

  @override
  String get name => "FractionallySizedBox";

}


 class FractionallySizedBoxElementWidget extends StatefulWidget with ElementWidgetMixin {
  FractionallySizedBoxElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _FractionallySizedBoxElementWidgetState createState() => _FractionallySizedBoxElementWidgetState();
}

class _FractionallySizedBoxElementWidgetState extends State<FractionallySizedBoxElementWidget> with ElementWidgetStateMixin<FractionallySizedBoxElement, FractionallySizedBoxElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: FractionallySizedBox(
          child: getChildOrDragTarget(
               childId: element.findIdForSlot(FractionallySizedBoxElement.CHILD),
               data: SlotData(slotName: FractionallySizedBoxElement.CHILD), 
             ),        
         heightFactor: element.heightFactor.value,
         widthFactor: element.widthFactor.value,
         alignment: element.alignment.value,
        )
    );
  }

} 
  