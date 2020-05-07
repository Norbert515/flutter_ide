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


class CardElement extends WidgetElement with SlotChildElementMixin {
  CardElement({
    @required String id,
    Clip clipBehavior,
    Color color,
    double elevation,
    EdgeInsets margin,
    bool semanticContainer,
  }) :
    clipBehavior = MClipProperty(
        value: clipBehavior?? null,
        name: "clipBehavior",
        defaultValue: null
    ),

    color = MColorProperty(
        value: color?? null,
        name: "color",
        defaultValue: null
    ),

    elevation = MDoubleProperty(
        value: elevation?? null,
        name: "elevation",
        defaultValue: null
    ),

    margin = MEdgeInsetsProperty(
        value: margin?? null,
        name: "margin",
        defaultValue: null
    ),

    semanticContainer = MBoolProperty(
        value: semanticContainer?? true,
        name: "semanticContainer",
        defaultValue: true
    ),


      super(id);

    final MClipProperty clipBehavior;
    final MColorProperty color;
    final MDoubleProperty elevation;
    final MEdgeInsetsProperty margin;
    final MBoolProperty semanticContainer;

    static const String CHILD = "child";

  @override
  List<ChildSlot> constructChildSlots() => [
   SingleChildSlot(slotName: CHILD),
  ];  
  
  @override
  List<MProperty> get attributes => [
    clipBehavior,
    color,
    elevation,
    margin,
    semanticContainer,
  ];

  @override
  Widget generateWidget() {
    return CardElementWidget(
      id: id,
    );
  }

  factory CardElement.fromMap(Map<String, dynamic> map) {
    return CardElement(
        id: map["id"],
        clipBehavior: map["clipBehavior"],
        color: map["color"],
        elevation: map["elevation"],
        margin: map["margin"],
        semanticContainer: map["semanticContainer"],
    );
  }

  @override
  String get name => "Card";

}


 class CardElementWidget extends StatefulWidget with ElementWidgetMixin {
  CardElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _CardElementWidgetState createState() => _CardElementWidgetState();
}

class _CardElementWidgetState extends State<CardElementWidget> with ElementWidgetStateMixin<CardElement, CardElementWidget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: Card(
          child: getChildOrDragTarget(
               childId: element.findIdForSlot(CardElement.CHILD),
               data: SlotData(slotName: CardElement.CHILD), 
             ),        
         clipBehavior: element.clipBehavior.value,
         color: element.color.value,
         elevation: element.elevation.value,
         margin: element.margin.value,
         semanticContainer: element.semanticContainer.value,
        )
    );
  }

} 
  