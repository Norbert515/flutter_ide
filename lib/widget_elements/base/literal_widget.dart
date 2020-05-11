import 'package:flutter/material.dart';
import 'package:widget_maker_2_0/properties/add_property_property.dart';
import 'package:widget_maker_2_0/properties/basic_properties.dart';
import 'package:widget_maker_2_0/widget_elements/base/widget_element.dart';
import 'package:widget_maker_2_0/widget_elements/widgets/base.dart';


enum PropertyType {
  String, int, double, bool,
}

/// A representation of a widget in the source code.
class LiteralWidgetElement extends WidgetElement with SingleChildElement {

  LiteralWidgetElement({
    @required String id,
    String name,
  }):
     this.widgetName = MStringProperty(
       value: name,
       name: "name",
     ), super(id);

  final MStringProperty widgetName;
  final AddPropertyProperty addPropertyProperty = AddPropertyProperty(
    name: "Add Property"
  );

  List<MProperty> addedProperties = [];


  @override
  bool get isRoot => true;


  @override
  List<MProperty> get attributes => [widgetName, ...addedProperties, addPropertyProperty];

  @override
  Widget generateWidget() {
    return LiteralWidgetElementWidget(
      id: id,
    );
  }

  void addProperty(PropertyType type, String name) {
    addedProperties.add(MStringProperty(
      name: name,
      value: "",
    ));
  }

  @override
  String get name => "${widgetName.value}";

  @override
  String writeCode2(Map<String, WidgetElement> allElements) {
    if(!allElements.containsKey(childId)) {
      return "Text(\"Nothing here yet!\")";
    }
    return allElements[childId].writeCode2(allElements);
  }

}

class LiteralWidgetElementWidget extends StatefulWidget with ElementWidgetMixin {
  LiteralWidgetElementWidget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _LiteralWidgetElementWidgetState  createState() => _LiteralWidgetElementWidgetState  ();
}

class _LiteralWidgetElementWidgetState extends State<LiteralWidgetElementWidget> with ElementWidgetStateMixin<LiteralWidgetElement, LiteralWidgetElementWidget > {

  @override
  Widget getChildOrDragTarget({String childId, SlotData data, WidgetWrapper widgetWrapper}) {
    return widgetBoard.getWidgetElement(childId)?.generateWidget() ?? ElementDragTarget(id: widget.id, child: SizedBox.expand(), acceptingWidget: SizedBox.expand(),);
  }

  @override
  Widget build(BuildContext context) {
    return wrapWithSelector(
      child: Container(
        child: getChildOrDragTarget(childId: element.childId),
      ));
  }

}