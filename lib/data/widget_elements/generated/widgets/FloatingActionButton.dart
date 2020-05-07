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


class FloatingActionButtonElement extends WidgetElement with SlotChildElementMixin {
  FloatingActionButtonElement({
    @required String id,
    double elevation,
    String tooltip,
    Color foregroundColor,
    Color backgroundColor,
    Color focusColor,
    Color hoverColor,
    VoidCallback onPressed,
  }) :
    elevation = MDoubleProperty(
        value: elevation?? null,
        name: "elevation",
        defaultValue: null
    ),

    tooltip = MStringProperty(
        value: tooltip?? null,
        name: "tooltip",
        defaultValue: null
    ),

    foregroundColor = MColorProperty(
        value: foregroundColor?? null,
        name: "foregroundColor",
        defaultValue: null
    ),

    backgroundColor = MColorProperty(
        value: backgroundColor?? null,
        name: "backgroundColor",
        defaultValue: null
    ),

    focusColor = MColorProperty(
        value: focusColor?? null,
        name: "focusColor",
        defaultValue: null
    ),

    hoverColor = MColorProperty(
        value: hoverColor?? null,
        name: "hoverColor",
        defaultValue: null
    ),

    onPressed = MWIPProperty<VoidCallback>(
        value: onPressed?? null,
        name: "onPressed",
        defaultValue: null
    ),


      super(id);

    final MDoubleProperty elevation;
    final MStringProperty tooltip;
    final MColorProperty foregroundColor;
    final MColorProperty backgroundColor;
    final MColorProperty focusColor;
    final MColorProperty hoverColor;
    final MWIPProperty<VoidCallback> onPressed;

    static const String CHILD = "child";

  @override
  List<ChildSlot> constructChildSlots() => [
   SingleChildSlot(slotName: CHILD),
  ];  
  
  @override
  List<MProperty> get attributes => [
    elevation,
    tooltip,
    foregroundColor,
    backgroundColor,
    focusColor,
    hoverColor,
    onPressed,
  ];

  @override
  Widget generateWidget() {
    return FloatingActionButtonElementWidget(
      id: id,
    );
  }

  factory FloatingActionButtonElement.fromMap(Map<String, dynamic> map) {
    return FloatingActionButtonElement(
        id: map["id"],
        elevation: map["elevation"],
        tooltip: map["tooltip"],
        foregroundColor: map["foregroundColor"],
        backgroundColor: map["backgroundColor"],
        focusColor: map["focusColor"],
        hoverColor: map["hoverColor"],
        onPressed: map["onPressed"],
    );
  }

  @override
  String get name => "FloatingActionButton";

}


 class FloatingActionButtonElementWidget extends StatefulWidget with ElementWidgetMixin {
  FloatingActionButtonElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _FloatingActionButtonElementWidgetState createState() => _FloatingActionButtonElementWidgetState();
}

class _FloatingActionButtonElementWidgetState extends State<FloatingActionButtonElementWidget> with ElementWidgetStateMixin<FloatingActionButtonElement, FloatingActionButtonElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: FloatingActionButton(
          child: getChildOrDragTarget(
               childId: element.findIdForSlot(FloatingActionButtonElement.CHILD),
               data: SlotData(slotName: FloatingActionButtonElement.CHILD), 
             ),        
         elevation: element.elevation.value,
         tooltip: element.tooltip.value,
         foregroundColor: element.foregroundColor.value,
         backgroundColor: element.backgroundColor.value,
         focusColor: element.focusColor.value,
         hoverColor: element.hoverColor.value,
         onPressed: element.onPressed.value,
        )
    );
  }

} 
  