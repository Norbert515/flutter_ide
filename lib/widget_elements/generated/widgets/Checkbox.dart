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


class CheckboxElement extends WidgetElement with NoChildElementMixin {
  CheckboxElement({
    @required String id,
    Color activeColor,
    Color checkColor,
    bool tristate,
    bool value,
  }) :
    activeColor = MColorProperty(
        value: activeColor?? null,
        name: "activeColor",
        defaultValue: null
    ),

    checkColor = MColorProperty(
        value: checkColor?? null,
        name: "checkColor",
        defaultValue: null
    ),

    tristate = MBoolProperty(
        value: tristate?? false,
        name: "tristate",
        defaultValue: false
    ),

    value = MBoolProperty(
        value: value?? true,
        name: "value",
        isRequired: true,
        defaultValue: true
    ),


      super(id);

    final MColorProperty activeColor;
    final MColorProperty checkColor;
    final MBoolProperty tristate;
    final MBoolProperty value;

  
  @override
  List<MProperty> get attributes => [
    activeColor,
    checkColor,
    tristate,
    value,
  ];

  @override
  Widget generateWidget() {
    return CheckboxElementWidget(
      id: id,
    );
  }

  factory CheckboxElement.fromMap(Map<String, dynamic> map) {
    return CheckboxElement(
        id: map["id"],
        activeColor: map["activeColor"],
        checkColor: map["checkColor"],
        tristate: map["tristate"],
        value: map["value"],
    );
  }

  @override
  String get name => "Checkbox";

}


 class CheckboxElementWidget extends StatefulWidget with ElementWidgetMixin {
  CheckboxElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _CheckboxElementWidgetState createState() => _CheckboxElementWidgetState();
}

class _CheckboxElementWidgetState extends State<CheckboxElementWidget> with ElementWidgetStateMixin<CheckboxElement, CheckboxElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: Checkbox(
        
         activeColor: element.activeColor.value,
         checkColor: element.checkColor.value,
         tristate: element.tristate.value,
         value: element.value.value,
        )
    );
  }

} 
  