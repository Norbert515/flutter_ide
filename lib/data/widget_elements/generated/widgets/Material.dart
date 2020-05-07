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


class MaterialElement extends WidgetElement with SlotChildElementMixin {
  MaterialElement({
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
    return MaterialElementWidget(
      id: id,
    );
  }

  factory MaterialElement.fromMap(Map<String, dynamic> map) {
    return MaterialElement(
        id: map["id"],
    );
  }

  @override
  String get name => "Material";

}


 class MaterialElementWidget extends StatefulWidget with ElementWidgetMixin {
  MaterialElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _MaterialElementWidgetState createState() => _MaterialElementWidgetState();
}

class _MaterialElementWidgetState extends State<MaterialElementWidget> with ElementWidgetStateMixin<MaterialElement, MaterialElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: Material(
          child: getChildOrDragTarget(
               childId: element.findIdForSlot(MaterialElement.CHILD),
               data: SlotData(slotName: MaterialElement.CHILD), 
             ),        

        )
    );
  }

} 
  