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


class FormElement extends WidgetElement with SlotChildElementMixin {
  FormElement({
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
    return FormElementWidget(
      id: id,
    );
  }

  factory FormElement.fromMap(Map<String, dynamic> map) {
    return FormElement(
        id: map["id"],
    );
  }

  @override
  String get name => "Form";

}


 class FormElementWidget extends StatefulWidget with ElementWidgetMixin {
  FormElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _FormElementWidgetState createState() => _FormElementWidgetState();
}

class _FormElementWidgetState extends State<FormElementWidget> with ElementWidgetStateMixin<FormElement, FormElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: Form(
          child: getChildOrDragTarget(
               childId: element.findIdForSlot(FormElement.CHILD),
               data: SlotData(slotName: FormElement.CHILD), 
             ),        

        )
    );
  }

} 
  