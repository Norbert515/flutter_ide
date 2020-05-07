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


class ChipElement extends WidgetElement with SlotChildElementMixin {
  ChipElement({
    @required String id,
    Color backgroundColor,
    Clip clipBehavior,
    String deleteButtonTooltipMessage,
    Color deleteIconColor,
    double elevation,
    EdgeInsets labelPadding,
    TextStyle labelStyle,
    EdgeInsets padding,
    Color shadowColor,
  }) :
    backgroundColor = MColorProperty(
        value: backgroundColor?? null,
        name: "backgroundColor",
        defaultValue: null
    ),

    clipBehavior = MClipProperty(
        value: clipBehavior?? Clip.none,
        name: "clipBehavior",
        defaultValue: Clip.none
    ),

    deleteButtonTooltipMessage = MStringProperty(
        value: deleteButtonTooltipMessage?? null,
        name: "deleteButtonTooltipMessage",
        defaultValue: null
    ),

    deleteIconColor = MColorProperty(
        value: deleteIconColor?? null,
        name: "deleteIconColor",
        defaultValue: null
    ),

    elevation = MDoubleProperty(
        value: elevation?? null,
        name: "elevation",
        defaultValue: null
    ),

    labelPadding = MEdgeInsetsProperty(
        value: labelPadding?? null,
        name: "labelPadding",
        defaultValue: null
    ),

    labelStyle = MTextStyleProperty(
        value: labelStyle?? null,
        name: "labelStyle",
        defaultValue: null
    ),

    padding = MEdgeInsetsProperty(
        value: padding?? null,
        name: "padding",
        defaultValue: null
    ),

    shadowColor = MColorProperty(
        value: shadowColor?? null,
        name: "shadowColor",
        defaultValue: null
    ),


      super(id);

    final MColorProperty backgroundColor;
    final MClipProperty clipBehavior;
    final MStringProperty deleteButtonTooltipMessage;
    final MColorProperty deleteIconColor;
    final MDoubleProperty elevation;
    final MEdgeInsetsProperty labelPadding;
    final MTextStyleProperty labelStyle;
    final MEdgeInsetsProperty padding;
    final MColorProperty shadowColor;

    static const String AVATAR = "avatar";
  static const String DELETEICON = "deleteIcon";
  static const String LABEL = "label";

  @override
  List<ChildSlot> constructChildSlots() => [
   SingleChildSlot(slotName: AVATAR),
   SingleChildSlot(slotName: DELETEICON),
   SingleChildSlot(slotName: LABEL),
  ];  
  
  @override
  List<MProperty> get attributes => [
    backgroundColor,
    clipBehavior,
    deleteButtonTooltipMessage,
    deleteIconColor,
    elevation,
    labelPadding,
    labelStyle,
    padding,
    shadowColor,
  ];

  @override
  Widget generateWidget() {
    return ChipElementWidget(
      id: id,
    );
  }

  factory ChipElement.fromMap(Map<String, dynamic> map) {
    return ChipElement(
        id: map["id"],
        backgroundColor: map["backgroundColor"],
        clipBehavior: map["clipBehavior"],
        deleteButtonTooltipMessage: map["deleteButtonTooltipMessage"],
        deleteIconColor: map["deleteIconColor"],
        elevation: map["elevation"],
        labelPadding: map["labelPadding"],
        labelStyle: map["labelStyle"],
        padding: map["padding"],
        shadowColor: map["shadowColor"],
    );
  }

  @override
  String get name => "Chip";

}


 class ChipElementWidget extends StatefulWidget with ElementWidgetMixin {
  ChipElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _ChipElementWidgetState createState() => _ChipElementWidgetState();
}

class _ChipElementWidgetState extends State<ChipElementWidget> with ElementWidgetStateMixin<ChipElement, ChipElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: Chip(
          avatar: getChildOrDragTarget(
               childId: element.findIdForSlot(ChipElement.AVATAR),
               data: SlotData(slotName: ChipElement.AVATAR), 
             ),          deleteIcon: getChildOrDragTarget(
               childId: element.findIdForSlot(ChipElement.DELETEICON),
               data: SlotData(slotName: ChipElement.DELETEICON), 
             ),          label: getChildOrDragTarget(
               childId: element.findIdForSlot(ChipElement.LABEL),
               data: SlotData(slotName: ChipElement.LABEL), 
             ),        
         backgroundColor: element.backgroundColor.value,
         clipBehavior: element.clipBehavior.value,
         deleteButtonTooltipMessage: element.deleteButtonTooltipMessage.value,
         deleteIconColor: element.deleteIconColor.value,
         elevation: element.elevation.value,
         labelPadding: element.labelPadding.value,
         labelStyle: element.labelStyle.value,
         padding: element.padding.value,
         shadowColor: element.shadowColor.value,
        )
    );
  }

} 
  