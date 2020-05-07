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


class AlignElement extends WidgetElement with SlotChildElementMixin {
  AlignElement({
    @required String id,
    double heightFactor,
    double widthFactor,
    Alignment alignment,
  }) :
    heightFactor = MDoubleProperty(
        value: heightFactor?? null,
        name: "heightFactor",
        defaultValue: null
    ),

    widthFactor = MDoubleProperty(
        value: widthFactor?? null,
        name: "widthFactor",
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
    return AlignElementWidget(
      id: id,
    );
  }

  factory AlignElement.fromMap(Map<String, dynamic> map) {
    return AlignElement(
        id: map["id"],
        heightFactor: map["heightFactor"],
        widthFactor: map["widthFactor"],
        alignment: map["alignment"],
    );
  }

  @override
  String get name => "Align";

}


 class AlignElementWidget extends StatefulWidget with ElementWidgetMixin {
  AlignElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _AlignElementWidgetState createState() => _AlignElementWidgetState();
}

class _AlignElementWidgetState extends State<AlignElementWidget> with ElementWidgetStateMixin<AlignElement, AlignElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: Align(
          child: getChildOrDragTarget(
               childId: element.findIdForSlot(AlignElement.CHILD),
               data: SlotData(slotName: AlignElement.CHILD), 
             ),        
         heightFactor: element.heightFactor.value,
         widthFactor: element.widthFactor.value,
         alignment: element.alignment.value,
        )
    );
  }

} 
  