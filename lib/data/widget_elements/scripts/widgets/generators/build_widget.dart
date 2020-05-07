import 'dart:io';

import 'package:widget_maker_2_0/data/widget_elements/scripts/properties/parser/models.dart';
import 'package:widget_maker_2_0/data/widget_elements/scripts/widgets/generators/serializer_generator.dart';
import 'package:widget_maker_2_0/data/widget_elements/scripts/widgets/generators/widget_generator.dart';
import 'package:widget_maker_2_0/data/widget_elements/scripts/widgets/models.dart';

void writeImporter(List<ParsedWidget> widgets) {
  var file = File("../generated/widgets/aaimporter.dart");
  file.writeAsStringSync(
    widgets.map((it) => it.name).map((it) => "export \"$it.dart\";").join("\n"),
  );
}

void writeWidget(ParsedWidget parsedWidget) async {
  var file = File("../generated/widgets/${parsedWidget.name}.dart");
  await file.writeAsString(WidgetGenerator.generateWidgetElement(parsedWidget));

}

void finalWidgetConverter(List<ParsedWidget> widgets) {
  File file = File("../generated/final_widget_converter.dart");
  var code = SerializerGenerator.finalGenerateConverter(widgets);

  file.writeAsStringSync(code);

}

void writeWidgetsSerializer(List<ParsedWidget> widgets, List<ObjectProp> props) {
  File file = File("../generated/serializers.dart");
  var code = SerializerGenerator.generateSerializer(widgets, props);

  file.writeAsStringSync(code);

}


String generateWidget(ParsedWidget parsedWidget) {

  String widgetNameElement = parsedWidget.elementName;

  String widgetName = parsedWidget.name;
  String useWidget = parsedWidget.generalInfo?.useWidget;

  if(useWidget != null)
    return "// Can be found in the widgets folder";

  return """
 class ${widgetNameElement}Widget extends StatefulWidget with ElementWidgetMixin {
  ${widgetNameElement}Widget({this.id}) : super(key: ObjectKey(id));

  final String id;

  @override
  _${widgetNameElement}WidgetState createState() => _${widgetNameElement}WidgetState();
}

class _${widgetNameElement}WidgetState extends State<${widgetNameElement}Widget> with ElementWidgetStateMixin<$widgetNameElement, ${widgetNameElement}Widget> {
  @override
  Widget build(BuildContext context) {
    return wrapWithDefault(
        child: ${useWidget?? widgetName}(
${widgetChildrenArguments(parsedWidget)}        
${widgetConstructorArguments(parsedWidget.properties).join("\n")}
        )
    );
  }

} 
  """;
}


List<String> widgetConstructorArguments(List<ParsedProperty> it) {
  it.sort((one, two) {
    if(one.positional == two.positional)
      return 0;
    if(one.positional && !two.positional)
      return -1;
    if(!one.positional && two.positional)
      return 1;
    return 0;
  });

  return it.map((prop) {
    if(prop.positional) {
      return "         element.${prop.name}.value,";
    }
    return "         ${prop.name}: element.${prop.name}.value,";
  }).toList();
}

String makeFirstBig(String it) {
  String starting = it.substring(0,1);
  return it.replaceRange(0, 1, starting.toUpperCase());
}


String getMaybeSlots(ParsedWidget widget) {
  if(!(widget.generalInfo.layoutModel is SlotChildLayoutModel))
    return "";

  SlotChildLayoutModel layoutModel = widget.generalInfo.layoutModel;

  String slots = layoutModel.slotNames.map((slot) {
    return "  static const String ${slot.name.toUpperCase()} = \"${slot.name}\";";
  }).join("\n");

  String getSlots = """
  @override
  List<ChildSlot> constructChildSlots() => [
${layoutModel.slotNames.map((it) => "   ${it.toCode()}(slotName: ${it.name.toUpperCase()}),").join("\n")}
  ];  
  """;

  return slots + "\n\n" + getSlots;
}

String widgetChildrenArguments(ParsedWidget widget) {
  String res = "";
  for(MapEntry<Slot, IdAndData> entry in widget.generalInfo.layoutModel.getPropertyAccess().entries) {
    res += "          ${entry.key.name}: getChildOrDragTarget(\n"
        "               childId: element.${entry.value.id},\n"
        "               data: ${entry.value.data}, \n${getMaxEmptySize(entry.value) ?? ""}"
        "             ),";
  }
  return res;
}

String getMaxEmptySize(IdAndData it) {
  if(it.maxEmptySize == null) return null;
  //return "               emptySize: Size(${it.maxEmptySize.width}, ${it.maxEmptySize.height})\n";
  return "               widgetWrapper: (context, child) => sizeWidgetWrapper(context, Size(${it.maxEmptySize.width},${it.maxEmptySize.height}), child)\n";
}
