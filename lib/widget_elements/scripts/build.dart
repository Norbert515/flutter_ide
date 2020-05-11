import 'dart:io';
import 'package:widget_maker_2_0/widget_elements/scripts/properties/build_property.dart';
import 'package:widget_maker_2_0/widget_elements/scripts/properties/parser/models.dart';
import 'package:widget_maker_2_0/widget_elements/scripts/properties/parser/parser.dart';
import 'package:widget_maker_2_0/widget_elements/scripts/widgets/generators/build_widget.dart';
import 'package:widget_maker_2_0/widget_elements/scripts/widgets/generators/bulid_registry.dart';
import 'package:widget_maker_2_0/widget_elements/scripts/widgets/parser.dart';
import 'package:yaml/yaml.dart';
import 'widgets/models.dart';


void main() async {
  var file = File("../config.yaml");
  String configContent = await file.readAsString();
  YamlMap parsedYaml = loadYaml(configContent);
  YamlMap widgets = parsedYaml["widgets"];

  List<ParsedWidget> parsedWidgets = [];
  for(String widget in widgets.keys) {

    YamlMap props = widgets[widget];

    ParsedWidget parsedWidget = parseWidget(widget, props);
    parsedWidgets.add(parsedWidget);

    writeWidget(parsedWidget);
  }


  writeImporter(parsedWidgets);
  await writeRegistry(parsedWidgets);



  print("Writing enums");
  List<ParsedProp> enums = parseEnumProperties();
  writeObjectProperties(enums.whereType<ObjectProp>().toList());
  writeEnumProperties(enums.whereType<ParsedEnum>().toList());

  print("Writing serializer");
  writeWidgetsSerializer(parsedWidgets, enums.whereType<ObjectProp>().toList());
  finalWidgetConverter(parsedWidgets);
}






